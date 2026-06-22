local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local WorkController = require(script.Parent.UIControllers.WorkController)

local existingGui = playerGui:FindFirstChild("IroncladMainGui")
if existingGui then
    existingGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "IroncladMainGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(18, 19, 24)
background.BorderSizePixel = 0
background.Parent = screenGui

local headerFrame = Instance.new("Frame")
headerFrame.Name = "HeaderFrame"
headerFrame.AnchorPoint = Vector2.new(0.5, 0)
headerFrame.Position = UDim2.fromScale(0.5, 0.03)
headerFrame.Size = UDim2.new(0.92, 0, 0.14, 0)
headerFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
headerFrame.BorderSizePixel = 0
headerFrame.Parent = background

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = headerFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.AnchorPoint = Vector2.new(0, 0)
title.Position = UDim2.fromScale(0.04, 0.10)
title.Size = UDim2.fromScale(0.55, 0.5)
title.BackgroundTransparency = 1
title.Text = "PROJECT IRONCLAD"
title.TextColor3 = Color3.fromRGB(235, 235, 235)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.Parent = headerFrame

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.AnchorPoint = Vector2.new(0, 0)
subtitle.Position = UDim2.fromScale(0.04, 0.58)
subtitle.Size = UDim2.fromScale(0.75, 0.28)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Office Clicker / Corporate Climb Simulator"
subtitle.TextColor3 = Color3.fromRGB(170, 170, 170)
subtitle.Font = Enum.Font.Gotham
subtitle.TextScaled = true
subtitle.Parent = headerFrame

local statsFrame = Instance.new("Frame")
statsFrame.Name = "StatsFrame"
statsFrame.AnchorPoint = Vector2.new(0, 0)
statsFrame.Position = UDim2.fromScale(0.04, 0.20)
statsFrame.Size = UDim2.fromScale(0.28, 0.44)
statsFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
statsFrame.BorderSizePixel = 0
statsFrame.Parent = background

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 16)
statsCorner.Parent = statsFrame

local statsStroke = Instance.new("UIStroke")
statsStroke.Color = Color3.fromRGB(72, 72, 84)
statsStroke.Transparency = 0.75
statsStroke.Parent = statsFrame

local statsHeader = Instance.new("TextLabel")
statsHeader.Name = "StatsHeader"
statsHeader.Size = UDim2.fromScale(0.9, 0.14)
statsHeader.Position = UDim2.fromScale(0.05, 0.03)
statsHeader.BackgroundTransparency = 1
statsHeader.Text = "CURRENT STATUS"
statsHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
statsHeader.Font = Enum.Font.GothamBold
statsHeader.TextScaled = true
statsHeader.TextXAlignment = Enum.TextXAlignment.Left
statsHeader.Parent = statsFrame

local moneyLabel = Instance.new("TextLabel")
moneyLabel.Name = "MoneyLabel"
moneyLabel.AnchorPoint = Vector2.new(0, 0)
moneyLabel.Position = UDim2.fromScale(0.05, 0.18)
moneyLabel.Size = UDim2.fromScale(0.9, 0.15)
moneyLabel.BackgroundTransparency = 1
moneyLabel.Text = "Money: £0"
moneyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
moneyLabel.Font = Enum.Font.GothamBold
moneyLabel.TextScaled = true
moneyLabel.TextXAlignment = Enum.TextXAlignment.Left
moneyLabel.Parent = statsFrame

local workPowerLabel = Instance.new("TextLabel")
workPowerLabel.Name = "WorkPowerLabel"
workPowerLabel.AnchorPoint = Vector2.new(0, 0)
workPowerLabel.Position = UDim2.fromScale(0.05, 0.35)
workPowerLabel.Size = UDim2.fromScale(0.9, 0.11)
workPowerLabel.BackgroundTransparency = 1
workPowerLabel.Text = "Earns £1 per click"
workPowerLabel.TextColor3 = Color3.fromRGB(185, 185, 185)
workPowerLabel.Font = Enum.Font.Gotham
workPowerLabel.TextScaled = true
workPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
workPowerLabel.Parent = statsFrame

local passiveIncomeLabel = Instance.new("TextLabel")
passiveIncomeLabel.Name = "PassiveIncomeLabel"
passiveIncomeLabel.AnchorPoint = Vector2.new(0, 0)
passiveIncomeLabel.Position = UDim2.fromScale(0.05, 0.50)
passiveIncomeLabel.Size = UDim2.fromScale(0.9, 0.11)
passiveIncomeLabel.BackgroundTransparency = 1
passiveIncomeLabel.Text = "Passive: £0 / sec"
passiveIncomeLabel.TextColor3 = Color3.fromRGB(185, 185, 185)
passiveIncomeLabel.Font = Enum.Font.Gotham
passiveIncomeLabel.TextScaled = true
passiveIncomeLabel.TextXAlignment = Enum.TextXAlignment.Left
passiveIncomeLabel.Parent = statsFrame

local prestigeStatusLabel = Instance.new("TextLabel")
prestigeStatusLabel.Name = "PrestigeStatusLabel"
prestigeStatusLabel.AnchorPoint = Vector2.new(0, 0)
prestigeStatusLabel.Position = UDim2.fromScale(0.05, 0.62)
prestigeStatusLabel.Size = UDim2.fromScale(0.9, 0.11)
prestigeStatusLabel.BackgroundTransparency = 1
prestigeStatusLabel.Text = "Prestige: 0"
prestigeStatusLabel.TextColor3 = Color3.fromRGB(185, 185, 185)
prestigeStatusLabel.Font = Enum.Font.Gotham
prestigeStatusLabel.TextScaled = true
prestigeStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
prestigeStatusLabel.Parent = statsFrame

local rebirthStatusLabel = Instance.new("TextLabel")
rebirthStatusLabel.Name = "RebirthStatusLabel"
rebirthStatusLabel.AnchorPoint = Vector2.new(0, 0)
rebirthStatusLabel.Position = UDim2.fromScale(0.05, 0.74)
rebirthStatusLabel.Size = UDim2.fromScale(0.9, 0.11)
rebirthStatusLabel.BackgroundTransparency = 1
rebirthStatusLabel.Text = "Rebirth: Locked"
rebirthStatusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
rebirthStatusLabel.Font = Enum.Font.Gotham
rebirthStatusLabel.TextScaled = true
rebirthStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
rebirthStatusLabel.Parent = statsFrame

local helpLabel = Instance.new("TextLabel")
helpLabel.Name = "HelpLabel"
helpLabel.AnchorPoint = Vector2.new(0, 0)
helpLabel.Position = UDim2.fromScale(0.05, 0.86)
helpLabel.Size = UDim2.fromScale(0.9, 0.10)
helpLabel.BackgroundTransparency = 1
helpLabel.Text = "Tip: Use promotions and workers to grow faster."
helpLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
helpLabel.Font = Enum.Font.Gotham
helpLabel.TextScaled = true
helpLabel.TextWrapped = true
helpLabel.TextXAlignment = Enum.TextXAlignment.Left
helpLabel.Parent = statsFrame

local actionFrame = Instance.new("Frame")
actionFrame.Name = "ActionFrame"
actionFrame.AnchorPoint = Vector2.new(0.5, 0)
actionFrame.Position = UDim2.fromScale(0.55, 0.20)
actionFrame.Size = UDim2.fromScale(0.36, 0.44)
actionFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
actionFrame.BorderSizePixel = 0
actionFrame.Parent = background

local actionCorner = Instance.new("UICorner")
actionCorner.CornerRadius = UDim.new(0, 16)
actionCorner.Parent = actionFrame

local actionStroke = Instance.new("UIStroke")
actionStroke.Color = Color3.fromRGB(72, 72, 84)
actionStroke.Transparency = 0.75
actionStroke.Parent = actionFrame

local actionHeader = Instance.new("TextLabel")
actionHeader.Name = "ActionHeader"
actionHeader.Size = UDim2.fromScale(0.9, 0.14)
actionHeader.Position = UDim2.fromScale(0.05, 0.03)
actionHeader.BackgroundTransparency = 1
actionHeader.Text = "ACTION"
actionHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
actionHeader.Font = Enum.Font.GothamBold
actionHeader.TextScaled = true
actionHeader.TextXAlignment = Enum.TextXAlignment.Left
actionHeader.Parent = actionFrame

local workButton = Instance.new("TextButton")
workButton.Name = "WorkButton"
workButton.AnchorPoint = Vector2.new(0.5, 0)
workButton.Position = UDim2.fromScale(0.5, 0.18)
workButton.Size = UDim2.fromScale(0.56, 0.42)
workButton.BackgroundColor3 = Color3.fromRGB(180, 35, 35)
workButton.BorderSizePixel = 0
workButton.Text = "WORK"
workButton.TextColor3 = Color3.fromRGB(255, 255, 255)
workButton.Font = Enum.Font.GothamBlack
workButton.TextScaled = true
workButton.Parent = actionFrame

local workCorner = Instance.new("UICorner")
workCorner.CornerRadius = UDim.new(0, 24)
workCorner.Parent = workButton

local workHintLabel = Instance.new("TextLabel")
workHintLabel.Name = "WorkHintLabel"
workHintLabel.AnchorPoint = Vector2.new(0.5, 0)
workHintLabel.Position = UDim2.fromScale(0.5, 0.66)
workHintLabel.Size = UDim2.fromScale(0.88, 0.22)
workHintLabel.BackgroundTransparency = 1
workHintLabel.Text = "Click WORK to earn money, then upgrade promotions and hiring."
workHintLabel.TextColor3 = Color3.fromRGB(185, 185, 185)
workHintLabel.Font = Enum.Font.Gotham
workHintLabel.TextScaled = true
workHintLabel.TextWrapped = true
workHintLabel.Parent = actionFrame

local quickActionsFrame = Instance.new("Frame")
quickActionsFrame.Name = "QuickActionsFrame"
quickActionsFrame.AnchorPoint = Vector2.new(0, 0)
quickActionsFrame.Position = UDim2.fromScale(0.04, 0.67)
quickActionsFrame.Size = UDim2.fromScale(0.28, 0.34)
quickActionsFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
quickActionsFrame.BorderSizePixel = 0
quickActionsFrame.Parent = background

local quickCorner = Instance.new("UICorner")
quickCorner.CornerRadius = UDim.new(0, 16)
quickCorner.Parent = quickActionsFrame

local quickStroke = Instance.new("UIStroke")
quickStroke.Color = Color3.fromRGB(72, 72, 84)
quickStroke.Transparency = 0.75
quickStroke.Parent = quickActionsFrame

local quickHeader = Instance.new("TextLabel")
quickHeader.Name = "QuickActionsHeader"
quickHeader.Size = UDim2.fromScale(0.9, 0.14)
quickHeader.Position = UDim2.fromScale(0.05, 0.03)
quickHeader.BackgroundTransparency = 1
quickHeader.Text = "QUICK ACTIONS"
quickHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
quickHeader.Font = Enum.Font.GothamBold
quickHeader.TextScaled = true
quickHeader.TextXAlignment = Enum.TextXAlignment.Left
quickHeader.Parent = quickActionsFrame

local promotionButton = Instance.new("TextButton")
promotionButton.Name = "PromotionsButton"
promotionButton.AnchorPoint = Vector2.new(0, 0)
promotionButton.Position = UDim2.fromScale(0.05, 0.12)
promotionButton.Size = UDim2.fromScale(0.9, 0.18)
promotionButton.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
promotionButton.BorderSizePixel = 0
promotionButton.Text = "Promotions"
promotionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
promotionButton.Font = Enum.Font.GothamBold
promotionButton.TextScaled = true
promotionButton.Parent = quickActionsFrame

local promotionCorner = Instance.new("UICorner")
promotionCorner.CornerRadius = UDim.new(0, 12)
promotionCorner.Parent = promotionButton

local hiringButton = Instance.new("TextButton")
hiringButton.Name = "HiringButton"
hiringButton.AnchorPoint = Vector2.new(0, 0)
hiringButton.Position = UDim2.fromScale(0.05, 0.34)
hiringButton.Size = UDim2.fromScale(0.9, 0.18)
hiringButton.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
hiringButton.BorderSizePixel = 0
hiringButton.Text = "Hiring"
hiringButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hiringButton.Font = Enum.Font.GothamBold
hiringButton.TextScaled = true
hiringButton.Parent = quickActionsFrame

local hiringCorner = Instance.new("UICorner")
hiringCorner.CornerRadius = UDim.new(0, 12)
hiringCorner.Parent = hiringButton

local rebirthButton = Instance.new("TextButton")
rebirthButton.Name = "RebirthToggleButton"
rebirthButton.AnchorPoint = Vector2.new(0, 0)
rebirthButton.Position = UDim2.fromScale(0.05, 0.56)
rebirthButton.Size = UDim2.fromScale(0.9, 0.18)
rebirthButton.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
rebirthButton.BorderSizePixel = 0
rebirthButton.Text = "Rebirth"
rebirthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rebirthButton.Font = Enum.Font.GothamBold
rebirthButton.TextScaled = true
rebirthButton.Parent = quickActionsFrame

local rebirthCorner = Instance.new("UICorner")
rebirthCorner.CornerRadius = UDim.new(0, 12)
rebirthCorner.Parent = rebirthButton

local shopButton = Instance.new("TextButton")
shopButton.Name = "ShopButton"
shopButton.AnchorPoint = Vector2.new(0, 0)
shopButton.Position = UDim2.fromScale(0.05, 0.78)
shopButton.Size = UDim2.fromScale(0.9, 0.18)
shopButton.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
shopButton.BorderSizePixel = 0
shopButton.Text = "Store"
shopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
shopButton.Font = Enum.Font.GothamBold
shopButton.TextScaled = true
shopButton.Parent = quickActionsFrame

local shopCorner = Instance.new("UICorner")
shopCorner.CornerRadius = UDim.new(0, 12)
shopCorner.Parent = shopButton

WorkController.Init({
    WorkButton = workButton,
    MoneyLabel = moneyLabel,
    WorkPowerLabel = workPowerLabel,
})

-- Promotions modal UI (minimal, hidden by default)
local promotionsModal = Instance.new("Frame")
promotionsModal.Name = "PromotionsModal"
promotionsModal.AnchorPoint = Vector2.new(0.5, 0.5)
promotionsModal.Position = UDim2.fromScale(0.5, 0.5)
promotionsModal.Size = UDim2.fromScale(0.5, 0.5)
promotionsModal.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
promotionsModal.Visible = false
promotionsModal.Parent = background

local header = Instance.new("TextLabel")
header.Name = "Header"
header.Size = UDim2.fromScale(1, 0.12)
header.Position = UDim2.fromScale(0, 0)
header.BackgroundTransparency = 1
header.Text = "Promotions"
header.TextColor3 = Color3.fromRGB(240, 240, 240)
header.Font = Enum.Font.GothamBold
header.TextScaled = true
header.Parent = promotionsModal

local playerMoney = Instance.new("TextLabel")
playerMoney.Name = "PlayerMoney"
playerMoney.Size = UDim2.fromScale(1, 0.12)
playerMoney.Position = UDim2.fromScale(0, 0.12)
playerMoney.BackgroundTransparency = 1
playerMoney.Text = "Money: £0"
playerMoney.TextColor3 = Color3.fromRGB(255, 255, 255)
playerMoney.Font = Enum.Font.Gotham
playerMoney.TextScaled = true
playerMoney.Parent = promotionsModal

local playerWorkPower = Instance.new("TextLabel")
playerWorkPower.Name = "PlayerWorkPower"
playerWorkPower.Size = UDim2.fromScale(1, 0.1)
playerWorkPower.Position = UDim2.fromScale(0, 0.24)
playerWorkPower.BackgroundTransparency = 1
playerWorkPower.Text = "Per-click: £1.00"
playerWorkPower.TextColor3 = Color3.fromRGB(200, 200, 200)
playerWorkPower.Font = Enum.Font.Gotham
playerWorkPower.TextScaled = true
playerWorkPower.Parent = promotionsModal

local promotionTile = Instance.new("Frame")
promotionTile.Name = "PromotionTile"
promotionTile.Size = UDim2.fromScale(0.9, 0.35)
promotionTile.Position = UDim2.fromScale(0.05, 0.38)
promotionTile.BackgroundColor3 = Color3.fromRGB(40, 42, 50)
promotionTile.Parent = promotionsModal

local tierName = Instance.new("TextLabel")
tierName.Name = "TierName"
tierName.Size = UDim2.fromScale(0.6, 0.2)
tierName.Position = UDim2.fromScale(0.02, 0.02)
tierName.BackgroundTransparency = 1
tierName.Text = "Promotion"
tierName.TextColor3 = Color3.fromRGB(240, 240, 240)
tierName.Font = Enum.Font.GothamBold
tierName.TextScaled = true
tierName.Parent = promotionTile

local ownedLevel = Instance.new("TextLabel")
ownedLevel.Name = "OwnedLevel"
ownedLevel.Size = UDim2.fromScale(0.3, 0.15)
ownedLevel.Position = UDim2.fromScale(0.02, 0.24)
ownedLevel.BackgroundTransparency = 1
ownedLevel.Text = "Level 0"
ownedLevel.TextColor3 = Color3.fromRGB(200, 200, 200)
ownedLevel.Font = Enum.Font.Gotham
ownedLevel.TextScaled = true
ownedLevel.Parent = promotionTile

local currentMultiplier = Instance.new("TextLabel")
currentMultiplier.Name = "CurrentMultiplier"
currentMultiplier.Size = UDim2.fromScale(0.3, 0.15)
currentMultiplier.Position = UDim2.fromScale(0.34, 0.24)
currentMultiplier.BackgroundTransparency = 1
currentMultiplier.Text = "+0%"
currentMultiplier.TextColor3 = Color3.fromRGB(200, 200, 200)
currentMultiplier.Font = Enum.Font.Gotham
currentMultiplier.TextScaled = true
currentMultiplier.Parent = promotionTile

local nextCost = Instance.new("TextLabel")
nextCost.Name = "NextCost"
nextCost.Size = UDim2.fromScale(0.6, 0.15)
nextCost.Position = UDim2.fromScale(0.02, 0.44)
nextCost.BackgroundTransparency = 1
nextCost.Text = "Cost: L0"
nextCost.TextColor3 = Color3.fromRGB(220, 220, 220)
nextCost.Font = Enum.Font.Gotham
nextCost.TextScaled = true
nextCost.Parent = promotionTile

local purchaseButton = Instance.new("TextButton")
purchaseButton.Name = "PurchaseButton"
purchaseButton.Size = UDim2.fromScale(0.3, 0.2)
purchaseButton.Position = UDim2.fromScale(0.6, 0.64)
purchaseButton.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
purchaseButton.Text = "Purchase"
purchaseButton.Font = Enum.Font.GothamBold
purchaseButton.TextScaled = true
purchaseButton.Parent = promotionTile

local insufficientLabel = Instance.new("TextLabel")
insufficientLabel.Name = "InsufficientLabel"
insufficientLabel.Size = UDim2.fromScale(0.9, 0.12)
insufficientLabel.Position = UDim2.fromScale(0.05, 0.78)
insufficientLabel.BackgroundTransparency = 1
insufficientLabel.Text = "Insufficient funds"
insufficientLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
insufficientLabel.Font = Enum.Font.Gotham
insufficientLabel.TextScaled = true
insufficientLabel.Parent = promotionsModal

-- Close button (top-right)
local closeButton = Instance.new("TextButton")
closeButton.Name = "PromotionsClose"
closeButton.Size = UDim2.fromScale(0.08, 0.08)
closeButton.Position = UDim2.fromScale(0.92, 0.02)
closeButton.AnchorPoint = Vector2.new(1, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
closeButton.Parent = promotionsModal

-- Hiring panel UI
local hiringPanel = Instance.new("Frame")
hiringPanel.Name = "HiringPanel"
hiringPanel.AnchorPoint = Vector2.new(0.5, 0.5)
hiringPanel.Position = UDim2.fromScale(0.5, 0.5)
hiringPanel.Size = UDim2.fromScale(0.5, 0.5)
hiringPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
hiringPanel.Visible = false
hiringPanel.Parent = background

local hiringHeader = Instance.new("TextLabel")
hiringHeader.Name = "Header"
hiringHeader.Size = UDim2.fromScale(1, 0.12)
hiringHeader.Position = UDim2.fromScale(0, 0)
hiringHeader.BackgroundTransparency = 1
hiringHeader.Text = "Hiring"
hiringHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
hiringHeader.Font = Enum.Font.GothamBold
hiringHeader.TextScaled = true
hiringHeader.Parent = hiringPanel

local workerName = Instance.new("TextLabel")
workerName.Name = "WorkerNameLabel"
workerName.Size = UDim2.fromScale(0.9, 0.12)
workerName.Position = UDim2.fromScale(0.05, 0.14)
workerName.BackgroundTransparency = 1
workerName.Text = "Junior Worker"
workerName.TextColor3 = Color3.fromRGB(240, 240, 240)
workerName.Font = Enum.Font.GothamBold
workerName.TextScaled = true
workerName.Parent = hiringPanel

local workerCount = Instance.new("TextLabel")
workerCount.Name = "WorkerCountLabel"
workerCount.Size = UDim2.fromScale(0.9, 0.1)
workerCount.Position = UDim2.fromScale(0.05, 0.28)
workerCount.BackgroundTransparency = 1
workerCount.Text = "Owned: 0"
workerCount.TextColor3 = Color3.fromRGB(200, 200, 200)
workerCount.Font = Enum.Font.Gotham
workerCount.TextScaled = true
workerCount.Parent = hiringPanel

local workerCost = Instance.new("TextLabel")
workerCost.Name = "WorkerCostLabel"
workerCost.Size = UDim2.fromScale(0.9, 0.1)
workerCost.Position = UDim2.fromScale(0.05, 0.40)
workerCost.BackgroundTransparency = 1
workerCost.Text = "Cost: £0"
workerCost.TextColor3 = Color3.fromRGB(200, 200, 200)
workerCost.Font = Enum.Font.Gotham
workerCost.TextScaled = true
workerCost.Parent = hiringPanel

local workerIncome = Instance.new("TextLabel")
workerIncome.Name = "WorkerIncomeLabel"
workerIncome.Size = UDim2.fromScale(0.9, 0.2)
workerIncome.Position = UDim2.fromScale(0.05, 0.52)
workerIncome.BackgroundTransparency = 1
workerIncome.Text = "Income: £0 / worker\nTotal: £0 / sec"
workerIncome.TextColor3 = Color3.fromRGB(200, 200, 200)
workerIncome.Font = Enum.Font.Gotham
workerIncome.TextScaled = true
workerIncome.TextWrapped = true
workerIncome.Parent = hiringPanel

local buyWorkerButton = Instance.new("TextButton")
buyWorkerButton.Name = "BuyWorkerButton"
buyWorkerButton.Size = UDim2.fromScale(0.3, 0.12)
buyWorkerButton.Position = UDim2.fromScale(0.35, 0.76)
buyWorkerButton.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
buyWorkerButton.Text = "Hire"
buyWorkerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
buyWorkerButton.Font = Enum.Font.GothamBold
buyWorkerButton.TextScaled = true
buyWorkerButton.Parent = hiringPanel

local affordabilityLabel = Instance.new("TextLabel")
affordabilityLabel.Name = "AffordabilityLabel"
affordabilityLabel.Size = UDim2.fromScale(0.9, 0.12)
affordabilityLabel.Position = UDim2.fromScale(0.05, 0.88)
affordabilityLabel.BackgroundTransparency = 1
affordabilityLabel.Text = ""
affordabilityLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
affordabilityLabel.Font = Enum.Font.Gotham
affordabilityLabel.TextScaled = true
affordabilityLabel.Parent = hiringPanel

local hiringClose = Instance.new("TextButton")
hiringClose.Name = "HiringClose"
hiringClose.Size = UDim2.fromScale(0.08, 0.08)
hiringClose.Position = UDim2.fromScale(0.92, 0.02)
hiringClose.AnchorPoint = Vector2.new(1, 0)
hiringClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hiringClose.Text = "X"
hiringClose.TextColor3 = Color3.fromRGB(255, 255, 255)
hiringClose.Font = Enum.Font.GothamBold
hiringClose.TextScaled = true
hiringClose.Parent = hiringPanel

local rebirthPanel = Instance.new("Frame")
rebirthPanel.Name = "RebirthPanel"
rebirthPanel.AnchorPoint = Vector2.new(0.5, 0.5)
rebirthPanel.Position = UDim2.fromScale(0.5, 0.5)
rebirthPanel.Size = UDim2.fromScale(0.4, 0.35)
rebirthPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
rebirthPanel.Visible = false
rebirthPanel.Parent = background

local rebirthHeader = Instance.new("TextLabel")
rebirthHeader.Name = "Header"
rebirthHeader.Size = UDim2.fromScale(1, 0.12)
rebirthHeader.Position = UDim2.fromScale(0, 0)
rebirthHeader.BackgroundTransparency = 1
rebirthHeader.Text = "Rebirth"
rebirthHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
rebirthHeader.Font = Enum.Font.GothamBold
rebirthHeader.TextScaled = true
rebirthHeader.Parent = rebirthPanel

local prestigeLabel = Instance.new("TextLabel")
prestigeLabel.Name = "PrestigeLabel"
prestigeLabel.Size = UDim2.fromScale(0.9, 0.12)
prestigeLabel.Position = UDim2.fromScale(0.05, 0.14)
prestigeLabel.BackgroundTransparency = 1
prestigeLabel.Text = "Prestige: 0"
prestigeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
prestigeLabel.Font = Enum.Font.Gotham
prestigeLabel.TextScaled = true
prestigeLabel.Parent = rebirthPanel

local requirementLabel = Instance.new("TextLabel")
requirementLabel.Name = "RequirementLabel"
requirementLabel.Size = UDim2.fromScale(0.9, 0.12)
requirementLabel.Position = UDim2.fromScale(0.05, 0.28)
requirementLabel.BackgroundTransparency = 1
requirementLabel.Text = "Rebirth requires L0 money"
requirementLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
requirementLabel.Font = Enum.Font.Gotham
requirementLabel.TextScaled = true
requirementLabel.Parent = rebirthPanel

local descriptionLabel = Instance.new("TextLabel")
descriptionLabel.Name = "DescriptionLabel"
descriptionLabel.Size = UDim2.fromScale(0.9, 0.12)
descriptionLabel.Position = UDim2.fromScale(0.05, 0.42)
descriptionLabel.BackgroundTransparency = 1
descriptionLabel.Text = "+1% earnings per Prestige point"
descriptionLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
descriptionLabel.Font = Enum.Font.Gotham
descriptionLabel.TextScaled = true
descriptionLabel.Parent = rebirthPanel

local rebirthConfirmButton = Instance.new("TextButton")
rebirthConfirmButton.Name = "RebirthButton"
rebirthConfirmButton.Size = UDim2.fromScale(0.4, 0.16)
rebirthConfirmButton.Position = UDim2.fromScale(0.3, 0.6)
rebirthConfirmButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
rebirthConfirmButton.BorderSizePixel = 0
rebirthConfirmButton.Text = "Rebirth"
rebirthConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rebirthConfirmButton.Font = Enum.Font.GothamBold
rebirthConfirmButton.TextScaled = true
rebirthConfirmButton.Parent = rebirthPanel

local rebirthClose = Instance.new("TextButton")
rebirthClose.Name = "RebirthClose"
rebirthClose.Size = UDim2.fromScale(0.08, 0.08)
rebirthClose.Position = UDim2.fromScale(0.92, 0.02)
rebirthClose.AnchorPoint = Vector2.new(1, 0)
rebirthClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rebirthClose.Text = "X"
rebirthClose.TextColor3 = Color3.fromRGB(255, 255, 255)
rebirthClose.Font = Enum.Font.GothamBold
rebirthClose.TextScaled = true
rebirthClose.Parent = rebirthPanel

local shopPanel = Instance.new("Frame")
shopPanel.Name = "ShopPanel"
shopPanel.AnchorPoint = Vector2.new(0.5, 0.5)
shopPanel.Position = UDim2.fromScale(0.5, 0.5)
shopPanel.Size = UDim2.fromScale(0.55, 0.55)
shopPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
shopPanel.BorderSizePixel = 0
shopPanel.Visible = false
shopPanel.Parent = background

local shopHeader = Instance.new("TextLabel")
shopHeader.Name = "Header"
shopHeader.Size = UDim2.fromScale(1, 0.12)
shopHeader.Position = UDim2.fromScale(0, 0)
shopHeader.BackgroundTransparency = 1
shopHeader.Text = "Store"
shopHeader.TextColor3 = Color3.fromRGB(240, 240, 240)
shopHeader.Font = Enum.Font.GothamBold
shopHeader.TextScaled = true
shopHeader.Parent = shopPanel

local shopStatusLabel = Instance.new("TextLabel")
shopStatusLabel.Name = "ShopStatusLabel"
shopStatusLabel.Size = UDim2.fromScale(0.96, 0.08)
shopStatusLabel.Position = UDim2.fromScale(0.02, 0.88)
shopStatusLabel.BackgroundTransparency = 1
shopStatusLabel.Text = "Support development with optional boosts."
shopStatusLabel.TextColor3 = Color3.fromRGB(185, 185, 185)
shopStatusLabel.Font = Enum.Font.Gotham
shopStatusLabel.TextScaled = true
shopStatusLabel.TextWrapped = true
shopStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
shopStatusLabel.Parent = shopPanel

local shopContent = Instance.new("Frame")
shopContent.Name = "ShopContent"
shopContent.Size = UDim2.fromScale(0.96, 0.76)
shopContent.Position = UDim2.fromScale(0.02, 0.14)
shopContent.BackgroundTransparency = 1
shopContent.Parent = shopPanel

local shopProductList = Instance.new("ScrollingFrame")
shopProductList.Name = "ShopProductList"
shopProductList.Size = UDim2.fromScale(1, 1)
shopProductList.BackgroundTransparency = 1
shopProductList.CanvasSize = UDim2.new(0, 0, 0, 0)
shopProductList.AutomaticCanvasSize = Enum.AutomaticSize.Y
shopProductList.ScrollBarThickness = 6
shopProductList.Parent = shopContent

local shopPadding = Instance.new("UIPadding")
shopPadding.PaddingTop = UDim.new(0, 12)
shopPadding.PaddingBottom = UDim.new(0, 12)
shopPadding.PaddingLeft = UDim.new(0, 10)
shopPadding.PaddingRight = UDim.new(0, 10)
shopPadding.Parent = shopProductList

local shopListLayout = Instance.new("UIListLayout")
shopListLayout.Name = "ListLayout"
shopListLayout.SortOrder = Enum.SortOrder.LayoutOrder
shopListLayout.Padding = UDim.new(0, 14)
shopListLayout.Parent = shopProductList

local shopClose = Instance.new("TextButton")
shopClose.Name = "ShopClose"
shopClose.Size = UDim2.fromScale(0.08, 0.08)
shopClose.Position = UDim2.fromScale(0.92, 0.02)
shopClose.AnchorPoint = Vector2.new(1, 0)
shopClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
shopClose.Text = "X"
shopClose.TextColor3 = Color3.fromRGB(255, 255, 255)
shopClose.Font = Enum.Font.GothamBold
shopClose.TextScaled = true
shopClose.Parent = shopPanel

local PromotionsController = require(script.Parent.UIControllers.PromotionsController)
local HiringController = require(script.Parent.UIControllers.HiringController)
local RebirthController = require(script.Parent.UIControllers.RebirthController)
local ShopController = require(script.Parent.UIControllers.ShopController)

PromotionsController.Init({
    PromotionsButton = promotionButton,
    PromotionsModal = promotionsModal,
    PlayerMoney = playerMoney,
    PlayerWorkPower = playerWorkPower,
    OwnedLevel = ownedLevel,
    CurrentMultiplier = currentMultiplier,
    NextCost = nextCost,
    PurchaseButton = purchaseButton,
    InsufficientLabel = insufficientLabel,
    CloseButton = closeButton,
})

HiringController.Init({
    HiringButton = hiringButton,
    HiringPanel = hiringPanel,
    WorkerNameLabel = workerName,
    WorkerCountLabel = workerCount,
    WorkerCostLabel = workerCost,
    WorkerIncomeLabel = workerIncome,
    BuyWorkerButton = buyWorkerButton,
    AffordabilityLabel = affordabilityLabel,
    PassiveIncomeLabel = passiveIncomeLabel,
    CloseButton = hiringClose,
})

RebirthController.Init({
    RebirthToggleButton = rebirthButton,
    RebirthPanel = rebirthPanel,
    PrestigeLabel = prestigeLabel,
    RequirementLabel = requirementLabel,
    DescriptionLabel = descriptionLabel,
    PrestigeStatusLabel = prestigeStatusLabel,
    RebirthStatusLabel = rebirthStatusLabel,
    RebirthButton = rebirthConfirmButton,
    CloseButton = rebirthClose,
})

ShopController.Init({
    ShopButton = shopButton,
    ShopPanel = shopPanel,
    ShopStatusLabel = shopStatusLabel,
    ShopProductList = shopProductList,
    CloseButton = shopClose,
})
