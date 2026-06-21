local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)
local PromotionsConfig = require(Ironclad.Modules.Config.PromotionsConfig)

local PlayerDataService = require(script.Parent.PlayerDataService)

local PromotionService = {}

local function getOrCreateRemotes()
    local remotesFolder = Ironclad:FindFirstChild("Remotes")

    if not remotesFolder then
        remotesFolder = Instance.new("Folder")
        remotesFolder.Name = "Remotes"
        remotesFolder.Parent = Ironclad
    end

    local requestFunc = remotesFolder:FindFirstChild(SignalNames.RequestPurchasePromotion)
    if not requestFunc then
        requestFunc = Instance.new("RemoteFunction")
        requestFunc.Name = SignalNames.RequestPurchasePromotion
        requestFunc.Parent = remotesFolder
    end

    local dataFunc = remotesFolder:FindFirstChild(SignalNames.GetPlayerPromotionData)
    if not dataFunc then
        dataFunc = Instance.new("RemoteFunction")
        dataFunc.Name = SignalNames.GetPlayerPromotionData
        dataFunc.Parent = remotesFolder
    end

    local purchasedEvent = remotesFolder:FindFirstChild(SignalNames.PromotionPurchased)
    if not purchasedEvent then
        purchasedEvent = Instance.new("RemoteEvent")
        purchasedEvent.Name = SignalNames.PromotionPurchased
        purchasedEvent.Parent = remotesFolder
    end

    return requestFunc, dataFunc, purchasedEvent
end

local function round(n)
    return math.floor(n + 0.5)
end

function PromotionService.Start()
    local requestFunc, dataFunc, purchasedEvent = getOrCreateRemotes()

    requestFunc.OnServerInvoke = function(player, promotionId)
        -- single promotion track; ignore promotionId for now
        local data = PlayerDataService.GetData(player)
        if not data then
            PlayerDataService.InitPlayer(player)
            data = PlayerDataService.GetData(player)
        end

        local currentLevel = data.PromotionLevel or 0
        local nextLevel = currentLevel + 1

        local cost = round(PromotionsConfig.baseCost * (PromotionsConfig.scaleFactor ^ (nextLevel - 1)))

        if data.Money < cost then
            return { success = false, errorMessage = "Insufficient funds", newMoney = data.Money, newLevel = currentLevel, newPerClick = data.WorkPower }
        end

        local ok, newMoney = PlayerDataService.TrySpendMoney(player, cost)
        if not ok then
            return { success = false, errorMessage = "Insufficient funds", newMoney = data.Money, newLevel = currentLevel, newPerClick = data.WorkPower }
        end

        data.PromotionLevel = nextLevel
        local newPerClick = PromotionsConfig.baseWork * (PromotionsConfig.multiplierPerLevel ^ data.PromotionLevel)
        PlayerDataService.SetWorkPower(player, newPerClick)

        -- notify client(s)
        purchasedEvent:FireClient(player, { newMoney = newMoney, newLevel = data.PromotionLevel, newPerClick = newPerClick })

        return { success = true, newMoney = newMoney, newLevel = data.PromotionLevel, newPerClick = newPerClick }
    end

    dataFunc.OnServerInvoke = function(player)
        local data = PlayerDataService.GetData(player)
        if not data then
            PlayerDataService.InitPlayer(player)
            data = PlayerDataService.GetData(player)
        end

        local currentLevel = data.PromotionLevel or 0
        local nextLevel = currentLevel + 1
        local nextCost = round(PromotionsConfig.baseCost * (PromotionsConfig.scaleFactor ^ (nextLevel - 1)))
        local currentMultiplier = PromotionsConfig.multiplierPerLevel ^ currentLevel

        return {
            ownedLevel = currentLevel,
            nextCost = nextCost,
            currentMultiplier = currentMultiplier,
            currentPerClick = data.WorkPower,
            money = data.Money,
        }
    end

    Players.PlayerAdded:Connect(function(player)
        -- nothing else needed here; player data service handles initial values
    end)

    print("[IRONCLAD] PromotionService active.")
end

return PromotionService
