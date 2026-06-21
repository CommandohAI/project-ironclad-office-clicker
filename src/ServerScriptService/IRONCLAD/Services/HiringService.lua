local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)
local HiringConfig = require(Ironclad.Modules.Config.HiringConfig)
local PlayerDataService = require(script.Parent.PlayerDataService)

local HiringService = {}
local passiveIncomeTasks = {}
local moneyUpdatedRemote = nil

local function getOrCreateRemote(name, className)
    local remotesFolder = Ironclad:FindFirstChild("Remotes")
    if not remotesFolder then
        remotesFolder = Instance.new("Folder")
        remotesFolder.Name = "Remotes"
        remotesFolder.Parent = Ironclad
    end

    local remote = remotesFolder:FindFirstChild(name)
    if not remote then
        remote = Instance.new(className)
        remote.Name = name
        remote.Parent = remotesFolder
    end

    return remote
end

local function round(n)
    return math.floor(n + 0.5)
end

local function getCurrentWorkerCost(currentCount)
    if currentCount < 1 then
        return HiringConfig.baseWorkerCost
    end
    return round(HiringConfig.baseWorkerCost * (HiringConfig.costScaleFactor ^ currentCount))
end

local function sendHiringData(player)
    local remotesFolder = Ironclad:FindFirstChild("Remotes")
    if not remotesFolder then
        return
    end

    local dataEvent = remotesFolder:FindFirstChild(SignalNames.HiringDataUpdated)
    if not dataEvent then
        return
    end

    local data = PlayerDataService.GetData(player)
    if not data then
        return
    end

    local workerCount = data.WorkerCount or 0
    local currentCost = getCurrentWorkerCost(workerCount)
    local totalIncome = workerCount * HiringConfig.workerIncomePerSecond

    dataEvent:FireClient(player, {
        workerCount = workerCount,
        nextCost = currentCost,
        incomePerSecond = HiringConfig.workerIncomePerSecond,
        totalIncomePerSecond = totalIncome,
        money = data.Money,
    })
end

local function startPassiveIncome(player)
    if passiveIncomeTasks[player.UserId] then
        return
    end

    passiveIncomeTasks[player.UserId] = true
    task.spawn(function()
        while player.Parent do
            task.wait(1)
            local currentData = PlayerDataService.GetData(player)
            if not currentData then
                break
            end

            local currentWorkerCount = currentData.WorkerCount or 0
            if currentWorkerCount > 0 then
                PlayerDataService.AddMoney(player, currentWorkerCount * HiringConfig.workerIncomePerSecond)
                if moneyUpdatedRemote then
                    moneyUpdatedRemote:FireClient(player, currentData.Money, currentData.WorkPower)
                end
                sendHiringData(player)
            end
        end

        passiveIncomeTasks[player.UserId] = nil
    end)
end

function HiringService.Start()
    local requestFunc = getOrCreateRemote(SignalNames.RequestHireWorker, "RemoteFunction")
    local dataFunc = getOrCreateRemote(SignalNames.GetPlayerHiringData, "RemoteFunction")
    local dataEvent = getOrCreateRemote(SignalNames.HiringDataUpdated, "RemoteEvent")
    moneyUpdatedRemote = getOrCreateRemote(SignalNames.MoneyUpdated, "RemoteEvent")

    requestFunc.OnServerInvoke = function(player)
        local data = PlayerDataService.GetData(player)
        if not data then
            PlayerDataService.InitPlayer(player)
            data = PlayerDataService.GetData(player)
        end

        local workerCount = data.WorkerCount or 0
        local cost = getCurrentWorkerCost(workerCount)

        if data.Money < cost then
            return {
                success = false,
                errorMessage = "Insufficient funds",
                newMoney = data.Money,
                workerCount = workerCount,
                nextCost = cost,
                totalIncomePerSecond = workerCount * HiringConfig.workerIncomePerSecond,
            }
        end

        local ok, newMoney = PlayerDataService.TrySpendMoney(player, cost)
        if not ok then
            return {
                success = false,
                errorMessage = "Insufficient funds",
                newMoney = data.Money,
                workerCount = workerCount,
                nextCost = cost,
                totalIncomePerSecond = workerCount * HiringConfig.workerIncomePerSecond,
            }
        end

        data.WorkerCount = workerCount + 1
        local nextCost = getCurrentWorkerCost(data.WorkerCount)
        local totalIncome = data.WorkerCount * HiringConfig.workerIncomePerSecond

        startPassiveIncome(player)

        if moneyUpdatedRemote then
            moneyUpdatedRemote:FireClient(player, newMoney, data.WorkPower)
        end

        dataEvent:FireClient(player, {
            workerCount = data.WorkerCount,
            nextCost = nextCost,
            incomePerSecond = HiringConfig.workerIncomePerSecond,
            totalIncomePerSecond = totalIncome,
            money = newMoney,
        })

        return {
            success = true,
            newMoney = newMoney,
            workerCount = data.WorkerCount,
            nextCost = nextCost,
            incomePerSecond = HiringConfig.workerIncomePerSecond,
            totalIncomePerSecond = totalIncome,
        }
    end

    dataFunc.OnServerInvoke = function(player)
        local data = PlayerDataService.GetData(player)
        if not data then
            PlayerDataService.InitPlayer(player)
            data = PlayerDataService.GetData(player)
        end

        local workerCount = data.WorkerCount or 0
        local currentCost = getCurrentWorkerCost(workerCount)
        local totalIncome = workerCount * HiringConfig.workerIncomePerSecond

        return {
            workerCount = workerCount,
            nextCost = currentCost,
            incomePerSecond = HiringConfig.workerIncomePerSecond,
            totalIncomePerSecond = totalIncome,
            money = data.Money,
        }
    end

    Players.PlayerAdded:Connect(function(player)
        task.wait(0.5)
        sendHiringData(player)
        startPassiveIncome(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        passiveIncomeTasks[player.UserId] = nil
    end)

    for _, player in ipairs(Players:GetPlayers()) do
        task.defer(function()
            task.wait(0.5)
            sendHiringData(player)
            startPassiveIncome(player)
        end)
    end

    print("[IRONCLAD] HiringService active.")
end

return HiringService
