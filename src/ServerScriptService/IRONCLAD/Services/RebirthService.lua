local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)
local RebirthConfig = require(Ironclad.Modules.Config.RebirthConfig)
local PromotionsConfig = require(Ironclad.Modules.Config.PromotionsConfig)
local PlayerDataService = require(script.Parent.PlayerDataService)

local RebirthService = {}

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

local function round(value)
    return math.floor(value + 0.5)
end

local function getRebirthRequirement(data)
    local count = tonumber(data.RebirthCount) or 0
    return round(RebirthConfig.baseRequirement * (RebirthConfig.requirementScaleFactor ^ count))
end

local function getPrestigeBonusPercent(data)
    return (tonumber(data.Prestige) or 0) * RebirthConfig.prestigeBonusPercent
end

function RebirthService.Start()
    local requestFunc = getOrCreateRemote(SignalNames.RequestRebirth, "RemoteFunction")
    local dataFunc = getOrCreateRemote(SignalNames.GetPlayerRebirthData, "RemoteFunction")
    local rebirthEvent = getOrCreateRemote(SignalNames.RebirthPerformed, "RemoteEvent")
    local moneyUpdatedRemote = getOrCreateRemote(SignalNames.MoneyUpdated, "RemoteEvent")

    requestFunc.OnServerInvoke = function(player)
        local data = PlayerDataService.GetData(player)
        if not data then
            PlayerDataService.InitPlayer(player)
            data = PlayerDataService.GetData(player)
        end

        local requirement = getRebirthRequirement(data)
        if data.Money < requirement then
            return {
                success = false,
                errorMessage = "Not enough money to rebirth.",
                currentMoney = data.Money,
                nextRequirement = requirement,
                prestige = data.Prestige,
                rebirthCount = data.RebirthCount,
            }
        end

        data.Money = 0
        data.PromotionLevel = 0
        data.WorkPower = PromotionsConfig.baseWork
        data.WorkerCount = 0
        data.Prestige = (tonumber(data.Prestige) or 0) + RebirthConfig.prestigePerRebirth
        data.RebirthCount = (tonumber(data.RebirthCount) or 0) + 1

        local effectiveClickPower = round(data.WorkPower * PlayerDataService.GetPrestigeMultiplier(player))
        moneyUpdatedRemote:FireClient(player, data.Money, effectiveClickPower)

        local nextRequirement = getRebirthRequirement(data)
        rebirthEvent:FireClient(player, {
            success = true,
            prestige = data.Prestige,
            rebirthCount = data.RebirthCount,
            nextRequirement = nextRequirement,
        })

        return {
            success = true,
            prestige = data.Prestige,
            rebirthCount = data.RebirthCount,
            currentMoney = data.Money,
            nextRequirement = nextRequirement,
            currentWorkPower = effectiveClickPower,
        }
    end

    dataFunc.OnServerInvoke = function(player)
        local data = PlayerDataService.GetData(player)
        if not data then
            PlayerDataService.InitPlayer(player)
            data = PlayerDataService.GetData(player)
        end

        return {
            prestige = tonumber(data.Prestige) or 0,
            rebirthCount = tonumber(data.RebirthCount) or 0,
            currentMoney = data.Money,
            nextRequirement = getRebirthRequirement(data),
            prestigeBonusPercent = getPrestigeBonusPercent(data),
            currentWorkPower = round((data.WorkPower or 1) * PlayerDataService.GetPrestigeMultiplier(player)),
        }
    end

    print("[IRONCLAD] RebirthService active.")
end

return RebirthService
