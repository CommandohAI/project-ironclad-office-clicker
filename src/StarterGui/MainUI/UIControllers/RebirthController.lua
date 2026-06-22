local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)
local NumberFormatter = require(Ironclad.Modules.Shared.NumberFormatter)

local RebirthController = {}

function RebirthController.Init(ui)
    local remotes = Ironclad:WaitForChild("Remotes")
    local requestFunc = remotes:WaitForChild(SignalNames.RequestRebirth)
    local dataFunc = remotes:WaitForChild(SignalNames.GetPlayerRebirthData)
    local moneyUpdatedRemote = remotes:WaitForChild(SignalNames.MoneyUpdated)

    local rebirthToggleButton = ui.RebirthToggleButton
    local rebirthPanel = ui.RebirthPanel
    local prestigeLabel = ui.PrestigeLabel
    local requirementLabel = ui.RequirementLabel
    local descriptionLabel = ui.DescriptionLabel
    local rebirthButton = ui.RebirthButton
    local prestigeStatusLabel = ui.PrestigeStatusLabel
    local rebirthStatusLabel = ui.RebirthStatusLabel
    local rebirthClose = ui.CloseButton

    local currentRequirement = 0
    local currentMoney = 0

    local function updateButtonState()
        if currentMoney >= currentRequirement and currentRequirement > 0 then
            rebirthButton.Active = true
            rebirthButton.AutoButtonColor = true
            rebirthButton.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
            rebirthButton.Text = "Rebirth"
        else
            rebirthButton.Active = false
            rebirthButton.AutoButtonColor = false
            rebirthButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            rebirthButton.Text = "Rebirth"
        end
    end

    local function refreshRebirthData()
        local ok, data = pcall(function()
            return dataFunc:InvokeServer()
        end)

        if not ok or not data then
            return
        end

        currentRequirement = data.nextRequirement or 0
        currentMoney = data.currentMoney or 0

        local prestigeValue = tostring(data.prestige or 0)
        prestigeLabel.Text = "Prestige: " .. prestigeValue
        if prestigeStatusLabel then
            prestigeStatusLabel.Text = "Prestige: " .. prestigeValue
        end
        requirementLabel.Text = "Rebirth requires " .. NumberFormatter.FormatMoney(currentRequirement) .. " money"
        if rebirthStatusLabel then
            if currentMoney >= currentRequirement and currentRequirement > 0 then
                rebirthStatusLabel.Text = "Rebirth: Available"
                rebirthStatusLabel.TextColor3 = Color3.fromRGB(120, 220, 120)
            else
                rebirthStatusLabel.Text = "Rebirth: Locked"
                rebirthStatusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
            end
        end
        descriptionLabel.Text = "+" .. tostring(math.floor((data.prestigeBonusPercent or 0) * 100)) .. "% earnings per Prestige point"

        updateButtonState()
    end

    rebirthToggleButton.Activated:Connect(function()
        if rebirthPanel.Visible then
            rebirthPanel.Visible = false
            return
        end

        rebirthPanel.Visible = true
        refreshRebirthData()
    end)

    if rebirthClose then
        rebirthClose.Activated:Connect(function()
            rebirthPanel.Visible = false
        end)
    end

    rebirthButton.Activated:Connect(function()
        if not rebirthButton.Active then
            return
        end

        local ok, result = pcall(function()
            return requestFunc:InvokeServer()
        end)

        if not ok or not result then
            requirementLabel.Text = "Rebirth failed. Try again later."
            return
        end

        if result.success then
            currentRequirement = result.nextRequirement or currentRequirement
            currentMoney = result.currentMoney or 0
            local prestigeValue = tostring(result.prestige or 0)
            prestigeLabel.Text = "Prestige: " .. prestigeValue
            if prestigeStatusLabel then
                prestigeStatusLabel.Text = "Prestige: " .. prestigeValue
            end
            requirementLabel.Text = "Rebirth requires " .. NumberFormatter.FormatMoney(currentRequirement) .. " money"
            if rebirthStatusLabel then
                rebirthStatusLabel.Text = "Rebirth: Locked"
                rebirthStatusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
            end
            rebirthButton.Active = false
            rebirthButton.AutoButtonColor = false
            rebirthButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            rebirthPanel.Visible = false
        else
            requirementLabel.Text = result.errorMessage or "Not enough money to rebirth."
        end
    end)

    moneyUpdatedRemote.OnClientEvent:Connect(function(money)
        currentMoney = money or 0
        updateButtonState()
        if rebirthStatusLabel then
            if currentMoney >= currentRequirement and currentRequirement > 0 then
                rebirthStatusLabel.Text = "Rebirth: Available"
                rebirthStatusLabel.TextColor3 = Color3.fromRGB(120, 220, 120)
            else
                rebirthStatusLabel.Text = "Rebirth: Locked"
                rebirthStatusLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
            end
        end
    end)
end

return RebirthController
