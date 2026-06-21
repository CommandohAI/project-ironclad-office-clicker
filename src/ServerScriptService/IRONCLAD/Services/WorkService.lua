local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerDataService = require(script.Parent.PlayerDataService)

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)

local WorkService = {}

local cooldowns = {}
local CLICK_COOLDOWN = 0.12

local moneyUpdatedRemote

local function getOrCreateRemote(name)
    local remotesFolder = Ironclad:FindFirstChild("Remotes")

    if not remotesFolder then
        remotesFolder = Instance.new("Folder")
        remotesFolder.Name = "Remotes"
        remotesFolder.Parent = Ironclad
    end

    local remote = remotesFolder:FindFirstChild(name)

    if not remote then
        remote = Instance.new("RemoteEvent")
        remote.Name = name
        remote.Parent = remotesFolder
    end

    return remote
end

local function sendMoneyUpdate(player)
    if not moneyUpdatedRemote then
        return
    end

    local data = PlayerDataService.GetData(player)
    if not data then
        return
    end

    moneyUpdatedRemote:FireClient(player, data.Money, data.WorkPower)
end

function WorkService.Start()
    local workRequestRemote = getOrCreateRemote(SignalNames.WorkRequest)
    moneyUpdatedRemote = getOrCreateRemote(SignalNames.MoneyUpdated)

    workRequestRemote.OnServerEvent:Connect(function(player)
        local now = os.clock()
        local lastClick = cooldowns[player.UserId]

        if lastClick and now - lastClick < CLICK_COOLDOWN then
            return
        end

        cooldowns[player.UserId] = now

        local data = PlayerDataService.GetData(player)

        if not data then
            PlayerDataService.InitPlayer(player)
            data = PlayerDataService.GetData(player)
        end

        local earned = data.WorkPower or 1
        local newMoney = PlayerDataService.AddMoney(player, earned)

        moneyUpdatedRemote:FireClient(player, newMoney, earned)
    end)

    Players.PlayerAdded:Connect(function(player)
        task.wait(0.5)
        sendMoneyUpdate(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        cooldowns[player.UserId] = nil
    end)

    for _, player in ipairs(Players:GetPlayers()) do
        task.defer(function()
            task.wait(0.5)
            sendMoneyUpdate(player)
        end)
    end

    print("[IRONCLAD] WorkService active.")
end

return WorkService
