local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)
local NumberFormatter = require(Ironclad.Modules.Shared.NumberFormatter)

local PromotionsController = {}

function PromotionsController.Init(ui)
    local remotes = Ironclad:WaitForChild("Remotes")
    local requestFunc = remotes:WaitForChild(SignalNames.RequestPurchasePromotion)
    local dataFunc = remotes:WaitForChild(SignalNames.GetPlayerPromotionData)
    local purchasedEvent = remotes:WaitForChild(SignalNames.PromotionPurchased)
    local moneyUpdatedRemote = remotes:WaitForChild(SignalNames.MoneyUpdated)

    local promotionsButton = ui.PromotionsButton
    local modal = ui.PromotionsModal
    local playerMoneyLabel = ui.PlayerMoney
    local playerWorkPowerLabel = ui.PlayerWorkPower
    local ownedLevelLabel = ui.OwnedLevel
    local currentMultiplierLabel = ui.CurrentMultiplier
    local nextCostLabel = ui.NextCost
    local purchaseButton = ui.PurchaseButton
    local insufficientLabel = ui.InsufficientLabel

    modal.Visible = false
    insufficientLabel.Visible = false

    local function refreshData()
        local ok, data = pcall(function()
            return dataFunc:InvokeServer()
        end)

        if not ok or not data then
            return
        end

        playerMoneyLabel.Text = "Money: " .. NumberFormatter.FormatMoney(data.money)
        playerWorkPowerLabel.Text = "Per-click: " .. NumberFormatter.FormatMoney(data.currentPerClick)
        ownedLevelLabel.Text = "Level " .. tostring(data.ownedLevel)
        currentMultiplierLabel.Text = "+" .. tostring(math.floor((data.currentMultiplier - 1) * 100)) .. "%"
        nextCostLabel.Text = "Cost: " .. NumberFormatter.FormatMoney(data.nextCost)

        if data.money >= data.nextCost then
            purchaseButton.Active = true
            purchaseButton.AutoButtonColor = true
            purchaseButton.Text = "Purchase"
            purchaseButton.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
            insufficientLabel.Visible = false
        else
            purchaseButton.Active = false
            purchaseButton.AutoButtonColor = false
            purchaseButton.Text = "Purchase"
            purchaseButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            insufficientLabel.Visible = true
        end
    end

    promotionsButton.Activated:Connect(function()
        if modal.Visible then
            modal.Visible = false
            return
        end

        modal.Visible = true
        refreshData()
    end)

    if ui.CloseButton then
        ui.CloseButton.Activated:Connect(function()
            modal.Visible = false
        end)
    end

    purchaseButton.Activated:Connect(function()
        local result = nil
        local ok, res = pcall(function()
            return requestFunc:InvokeServer()
        end)

        if not ok or not res then
            insufficientLabel.Text = "Purchase failed"
            insufficientLabel.Visible = true
            return
        end

        result = res

        if result.success then
            -- update UI
            playerMoneyLabel.Text = "Money: " .. NumberFormatter.FormatMoney(result.newMoney)
            playerWorkPowerLabel.Text = "Per-click: " .. NumberFormatter.FormatMoney(result.newPerClick)
            ownedLevelLabel.Text = "Level " .. tostring(result.newLevel)

            local flash = TweenService:Create(playerMoneyLabel, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(100, 255, 100) })
            flash:Play()
            task.delay(0.25, function()
                playerMoneyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)
        else
            insufficientLabel.Text = result.errorMessage or "Insufficient funds"
            insufficientLabel.Visible = true
        end
    end)

    purchasedEvent.OnClientEvent:Connect(function(payload)
        -- server confirmed purchase
        playerMoneyLabel.Text = "Money: " .. NumberFormatter.FormatMoney(payload.newMoney)
        playerWorkPowerLabel.Text = "Per-click: " .. NumberFormatter.FormatMoney(payload.newPerClick)
        ownedLevelLabel.Text = "Level " .. tostring(payload.newLevel)
    end)

    moneyUpdatedRemote.OnClientEvent:Connect(function(money, workPower)
        playerMoneyLabel.Text = "Money: " .. NumberFormatter.FormatMoney(money)
        playerWorkPowerLabel.Text = "Per-click: " .. NumberFormatter.FormatMoney(workPower or 1)
    end)
end

return PromotionsController
