local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Ironclad = ReplicatedStorage:WaitForChild("IRONCLAD")
local SignalNames = require(Ironclad.Modules.Shared.SignalNames)
local NumberFormatter = require(Ironclad.Modules.Shared.NumberFormatter)

local WorkController = {}

function WorkController.Init(ui)
    local remotes = Ironclad:WaitForChild("Remotes")
    local workRequestRemote = remotes:WaitForChild(SignalNames.WorkRequest)
    local moneyUpdatedRemote = remotes:WaitForChild(SignalNames.MoneyUpdated)

    local workButton = ui.WorkButton
    local moneyLabel = ui.MoneyLabel
    local workPowerLabel = ui.WorkPowerLabel

    moneyLabel.Text = "Money: L0"
    workPowerLabel.Text = "Earns L1 per click"

    workButton.Activated:Connect(function()
        workRequestRemote:FireServer()

        local originalSize = workButton.Size
        workButton.Size = UDim2.fromScale(0.27, 0.19)

        local tween = TweenService:Create(
            workButton,
            TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Size = originalSize }
        )

        tween:Play()
    end)

    moneyUpdatedRemote.OnClientEvent:Connect(function(money, workPower)
        moneyLabel.Text = "Money: " .. NumberFormatter.FormatMoney(money)
        workPowerLabel.Text = "Earns " .. NumberFormatter.FormatMoney(workPower or 1) .. " per click"
    end)
end

return WorkController
