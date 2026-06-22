local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)
local NumberFormatter = require(Ironclad.Modules.Shared.NumberFormatter)

local ShopController = {}

local function createProductItem(product, onPurchaseRequested)
    local tile = Instance.new("Frame")
    tile.Name = "ShopItem"
    tile.Size = UDim2.new(1, 0, 0, 170)
    tile.BackgroundColor3 = Color3.fromRGB(38, 40, 48)
    tile.BorderSizePixel = 0

    local tileCorner = Instance.new("UICorner")
    tileCorner.CornerRadius = UDim.new(0, 12)
    tileCorner.Parent = tile

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0.6, 0, 0, 28)
    titleLabel.Position = UDim2.new(0.04, 0, 0.04, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = product.displayName
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextScaled = true
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = tile

    local descriptionLabel = Instance.new("TextLabel")
    descriptionLabel.Name = "Description"
    descriptionLabel.Size = UDim2.new(0.96, 0, 0, 46)
    descriptionLabel.Position = UDim2.new(0.04, 0, 0.24, 0)
    descriptionLabel.BackgroundTransparency = 1
    descriptionLabel.Text = product.description
    descriptionLabel.TextColor3 = Color3.fromRGB(185, 185, 185)
    descriptionLabel.Font = Enum.Font.Gotham
    descriptionLabel.TextScaled = true
    descriptionLabel.TextWrapped = true
    descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
    descriptionLabel.Parent = tile

    local rewardLabel = Instance.new("TextLabel")
    rewardLabel.Name = "Reward"
    rewardLabel.Size = UDim2.new(0.5, 0, 0, 24)
    rewardLabel.Position = UDim2.new(0.04, 0, 0.6, 0)
    rewardLabel.BackgroundTransparency = 1
    rewardLabel.Text = "Reward: " .. NumberFormatter.FormatMoney(product.rewardMoney)
    rewardLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    rewardLabel.Font = Enum.Font.Gotham
    rewardLabel.TextScaled = true
    rewardLabel.TextXAlignment = Enum.TextXAlignment.Left
    rewardLabel.Parent = tile

    local priceLabel = Instance.new("TextLabel")
    priceLabel.Name = "Price"
    priceLabel.Size = UDim2.new(0.4, 0, 0, 24)
    priceLabel.Position = UDim2.new(0.54, 0, 0.6, 0)
    priceLabel.BackgroundTransparency = 1
    priceLabel.Text = product.priceText
    priceLabel.TextColor3 = Color3.fromRGB(160, 240, 240)
    priceLabel.Font = Enum.Font.Gotham
    priceLabel.TextScaled = true
    priceLabel.TextXAlignment = Enum.TextXAlignment.Right
    priceLabel.Parent = tile

    local availabilityLabel = Instance.new("TextLabel")
    availabilityLabel.Name = "Availability"
    availabilityLabel.Size = UDim2.new(0.4, 0, 0, 20)
    availabilityLabel.Position = UDim2.new(0.04, 0, 0.74, 0)
    availabilityLabel.BackgroundTransparency = 1
    availabilityLabel.Text = ""
    availabilityLabel.TextColor3 = Color3.fromRGB(220, 180, 60)
    availabilityLabel.Font = Enum.Font.Gotham
    availabilityLabel.TextScaled = true
    availabilityLabel.TextXAlignment = Enum.TextXAlignment.Left
    availabilityLabel.Parent = tile

    local purchaseButton = Instance.new("TextButton")
    purchaseButton.Name = "PurchaseButton"
    purchaseButton.Size = UDim2.new(0.38, 0, 0, 34)
    purchaseButton.Position = UDim2.new(0.56, 0, 0.74, 0)
    purchaseButton.Font = Enum.Font.GothamBold
    purchaseButton.TextScaled = true
    purchaseButton.Parent = tile

    if product.available == false then
        purchaseButton.Text = "Coming Soon"
        purchaseButton.Active = false
        purchaseButton.AutoButtonColor = false
        purchaseButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        purchaseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        availabilityLabel.Text = "Unavailable"
    else
        purchaseButton.Text = "Purchase"
        purchaseButton.Active = true
        purchaseButton.AutoButtonColor = true
        purchaseButton.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
        purchaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    purchaseButton.Activated:Connect(function()
        if product.available == false then
            onPurchaseRequested(nil, false)
            return
        end

        onPurchaseRequested(product.key, true)
    end)

    return tile
end

function ShopController.Init(ui)
    local remotes = Ironclad:WaitForChild("Remotes")
    local requestFunc = remotes:WaitForChild(SignalNames.RequestPurchaseProduct)
    local dataFunc = remotes:WaitForChild(SignalNames.GetStoreData)
    local purchaseEvent = remotes:WaitForChild(SignalNames.PurchaseCompleted)

    local shopButton = ui.ShopButton
    local shopPanel = ui.ShopPanel
    local shopStatusLabel = ui.ShopStatusLabel
    local productList = ui.ShopProductList
    local closeButton = ui.CloseButton

    shopPanel.Visible = false
    shopStatusLabel.Text = "Support development with optional boosts."

    local function clearProductList()
        for _, child in ipairs(productList:GetChildren()) do
            if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
                child:Destroy()
            end
        end
    end

    local function updateStore()
        local ok, data = pcall(function()
            return dataFunc:InvokeServer()
        end)

        if not ok or not data or type(data.products) ~= "table" then
            shopStatusLabel.Text = "Unable to load store."
            return
        end

        clearProductList()
        for _, product in ipairs(data.products) do
            local item = createProductItem(product, function(productKey, isAvailable)
                if not isAvailable then
                    shopStatusLabel.Text = "This item is not available yet."
                    return
                end

                local purchaseOk, purchaseResult = pcall(function()
                    return requestFunc:InvokeServer(productKey)
                end)

                if not purchaseOk or not purchaseResult or not purchaseResult.success then
                    shopStatusLabel.Text = purchaseResult and purchaseResult.errorMessage or "Unable to start purchase."
                    return
                end

                shopStatusLabel.Text = "Purchase prompt shown. Complete the purchase to receive the reward."
            end)
            item.Parent = productList
        end
    end

    shopButton.Activated:Connect(function()
        shopPanel.Visible = not shopPanel.Visible
        if shopPanel.Visible then
            updateStore()
        end
    end)

    if closeButton then
        closeButton.Activated:Connect(function()
            shopPanel.Visible = false
        end)
    end

    purchaseEvent.OnClientEvent:Connect(function(payload)
        if payload and payload.productKey then
            shopStatusLabel.Text = "Purchase complete: " .. tostring(payload.productKey)
            updateStore()
        end
    end)
end

return ShopController
