local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MonetisationConfig = require(ReplicatedStorage:WaitForChild("IRONCLAD").Modules.Config.MonetisationConfig)
local SignalNames = require(ReplicatedStorage:WaitForChild("IRONCLAD").Modules.Shared.SignalNames)
local PlayerDataService = require(script.Parent.PlayerDataService)

local MonetisationService = {}

local function getOrCreateRemote(name, className)
    local remotesFolder = ReplicatedStorage.IRONCLAD:FindFirstChild("Remotes")
    if not remotesFolder then
        remotesFolder = Instance.new("Folder")
        remotesFolder.Name = "Remotes"
        remotesFolder.Parent = ReplicatedStorage.IRONCLAD
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

local function findProductConfigById(productId)
    for key, product in pairs(MonetisationConfig.developerProducts) do
        if product.ProductId == productId then
            return key, product
        end
    end
    return nil, nil
end

local function findProductConfigByKey(productKey)
    if type(productKey) ~= "string" then
        return nil, nil
    end

    local product = MonetisationConfig.developerProducts[productKey]
    if not product then
        return nil, nil
    end

    return productKey, product
end

local function sendMoneyUpdate(player)
    local data = PlayerDataService.GetData(player)
    if not data then
        return
    end

    local moneyUpdatedRemote = getOrCreateRemote(SignalNames.MoneyUpdated, "RemoteEvent")
    local multiplier = PlayerDataService.GetPrestigeMultiplier(player)
    local effectivePower = round((data.WorkPower or 1) * multiplier)

    moneyUpdatedRemote:FireClient(player, data.Money, effectivePower)
end

local function grantProductReward(player, productKey, product)
    local data = PlayerDataService.GetData(player)
    if not data then
        return false
    end

    data.Money = (data.Money or 0) + (product.RewardMoney or 0)

    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local moneyValue = leaderstats:FindFirstChild("Money")
        if moneyValue then
            moneyValue.Value = data.Money
        end
    end

    sendMoneyUpdate(player)
    return true
end

function MonetisationService.Start()
    local requestFunc = getOrCreateRemote(SignalNames.RequestPurchaseProduct, "RemoteFunction")
    local dataFunc = getOrCreateRemote(SignalNames.GetStoreData, "RemoteFunction")
    local purchaseEvent = getOrCreateRemote(SignalNames.PurchaseCompleted, "RemoteEvent")

    requestFunc.OnServerInvoke = function(player, productKey)
        local productId
        local _, product = findProductConfigByKey(productKey)
        if not product then
            return { success = false, errorMessage = "Invalid product." }
        end

        if product.Available == false or not product.ProductId or product.ProductId == 0 then
            return { success = false, errorMessage = "This item is not available yet." }
        end

        productId = product.ProductId
        local success, result = pcall(function()
            MarketplaceService:PromptProductPurchase(player, productId)
        end)

        if not success then
            warn("[IRONCLAD] Failed to prompt purchase for " .. tostring(productKey) .. ": " .. tostring(result))
            return { success = false, errorMessage = "Unable to start purchase." }
        end

        return { success = true }
    end

    dataFunc.OnServerInvoke = function(player)
        local data = PlayerDataService.GetData(player)
        if not data then
            PlayerDataService.InitPlayer(player)
            data = PlayerDataService.GetData(player)
        end

        local productList = {}
        for key, product in pairs(MonetisationConfig.developerProducts) do
            table.insert(productList, {
                key = key,
                displayName = product.DisplayName,
                description = product.Description,
                rewardMoney = product.RewardMoney,
                priceText = product.PriceText,
                available = product.Available ~= false,
            })
        end

        return {
            products = productList,
            money = data.Money,
        }
    end

    MarketplaceService.ProcessReceipt = function(receiptInfo)
        local productKey, product = findProductConfigById(receiptInfo.ProductId)
        if not productKey or not product then
            return Enum.ProductPurchaseDecision.NotProcessedYet
        end

        local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
        if not player then
            return Enum.ProductPurchaseDecision.NotProcessedYet
        end

        local data = PlayerDataService.GetData(player)
        if not data then
            return Enum.ProductPurchaseDecision.NotProcessedYet
        end

        local granted = grantProductReward(player, productKey, product)
        if not granted then
            return Enum.ProductPurchaseDecision.NotProcessedYet
        end

        local purchaseEvent = getOrCreateRemote(SignalNames.PurchaseCompleted, "RemoteEvent")
        purchaseEvent:FireClient(player, {
            productKey = productKey,
            rewardMoney = product.RewardMoney,
            newMoney = data.Money,
        })

        return Enum.ProductPurchaseDecision.PurchaseGranted
    end

    print("[IRONCLAD] MonetisationService active.")
end

return MonetisationService
