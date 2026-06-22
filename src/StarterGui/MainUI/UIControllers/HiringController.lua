local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)
local NumberFormatter = require(Ironclad.Modules.Shared.NumberFormatter)

local HiringController = {}

function HiringController.Init(ui)
    local remotes = Ironclad:WaitForChild("Remotes")
    local requestFunc = remotes:WaitForChild(SignalNames.RequestHireWorker)
    local dataFunc = remotes:WaitForChild(SignalNames.GetPlayerHiringData)
    local dataEvent = remotes:WaitForChild(SignalNames.HiringDataUpdated)

    local hiringButton = ui.HiringButton
    local hiringPanel = ui.HiringPanel
    local workerNameLabel = ui.WorkerNameLabel
    local workerCountLabel = ui.WorkerCountLabel
    local workerCostLabel = ui.WorkerCostLabel
    local workerIncomeLabel = ui.WorkerIncomeLabel
    local passiveIncomeLabel = ui.PassiveIncomeLabel
    local buyWorkerButton = ui.BuyWorkerButton
    local affordabilityLabel = ui.AffordabilityLabel
    local closeButton = ui.CloseButton

    hiringPanel.Visible = false
    affordabilityLabel.Visible = false

    if passiveIncomeLabel then
        passiveIncomeLabel.Text = "Passive: " .. NumberFormatter.FormatMoney(0) .. " / sec"
    end

    local function refreshData()
        local ok, data = pcall(function()
            return dataFunc:InvokeServer()
        end)

        if not ok or not data then
            return
        end

        workerNameLabel.Text = "Junior Worker"
        workerCountLabel.Text = "Owned: " .. tostring(data.workerCount)
        workerCostLabel.Text = "Cost: " .. NumberFormatter.FormatMoney(data.nextCost)
        workerIncomeLabel.Text = "Income: " .. NumberFormatter.FormatMoney(data.incomePerSecond) .. " / worker" .. "\nTotal: " .. NumberFormatter.FormatMoney(data.totalIncomePerSecond) .. " / sec"
        if passiveIncomeLabel then
            passiveIncomeLabel.Text = "Passive: " .. NumberFormatter.FormatMoney(data.totalIncomePerSecond or 0) .. " / sec"
        end

        if data.money >= data.nextCost then
            buyWorkerButton.Active = true
            buyWorkerButton.AutoButtonColor = true
            buyWorkerButton.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
            affordabilityLabel.Visible = false
        else
            buyWorkerButton.Active = false
            buyWorkerButton.AutoButtonColor = false
            buyWorkerButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            affordabilityLabel.Visible = true
            affordabilityLabel.Text = "Not enough money"
        end
    end

    hiringButton.Activated:Connect(function()
        hiringPanel.Visible = not hiringPanel.Visible
        if hiringPanel.Visible then
            refreshData()
        end
    end)

    if closeButton then
        closeButton.Activated:Connect(function()
            hiringPanel.Visible = false
        end)
    end

    buyWorkerButton.Activated:Connect(function()
        local result = nil
        local ok, res = pcall(function()
            return requestFunc:InvokeServer()
        end)

        if not ok or not res then
            affordabilityLabel.Text = "Purchase failed"
            affordabilityLabel.Visible = true
            return
        end

        result = res
        if result.success then
            workerCountLabel.Text = "Owned: " .. tostring(result.workerCount)
            workerCostLabel.Text = "Cost: " .. NumberFormatter.FormatMoney(result.nextCost)
            workerIncomeLabel.Text = "Income: " .. NumberFormatter.FormatMoney(result.incomePerSecond) .. " / worker" .. "\nTotal: " .. NumberFormatter.FormatMoney(result.totalIncomePerSecond) .. " / sec"
            if passiveIncomeLabel then
                passiveIncomeLabel.Text = "Passive: " .. NumberFormatter.FormatMoney(result.totalIncomePerSecond or 0) .. " / sec"
            end
            affordabilityLabel.Visible = false

            local flash = TweenService:Create(workerCountLabel, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(100, 255, 100) })
            flash:Play()
            task.delay(0.25, function()
                workerCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)
        else
            affordabilityLabel.Text = result.errorMessage or "Insufficient funds"
            affordabilityLabel.Visible = true
        end
    end)

    dataEvent.OnClientEvent:Connect(function(payload)
        workerCountLabel.Text = "Owned: " .. tostring(payload.workerCount)
        workerCostLabel.Text = "Cost: " .. NumberFormatter.FormatMoney(payload.nextCost)
        workerIncomeLabel.Text = "Income: " .. NumberFormatter.FormatMoney(payload.incomePerSecond) .. " / worker" .. "\nTotal: " .. NumberFormatter.FormatMoney(payload.totalIncomePerSecond) .. " / sec"
        if passiveIncomeLabel then
            passiveIncomeLabel.Text = "Passive: " .. NumberFormatter.FormatMoney(payload.totalIncomePerSecond or 0) .. " / sec"
        end
    end)
end

return HiringController
