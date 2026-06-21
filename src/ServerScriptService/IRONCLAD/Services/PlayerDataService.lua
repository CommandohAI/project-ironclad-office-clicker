local Players = game:GetService("Players")

local PlayerDataService = {}

local profiles = {}

local DEFAULT_DATA = {
    Money = 0,
    WorkPower = 1,
    PromotionLevel = 0,
}

local function createLeaderstats(player, data)
    local oldLeaderstats = player:FindFirstChild("leaderstats")
    if oldLeaderstats then
        oldLeaderstats:Destroy()
    end

    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local money = Instance.new("NumberValue")
    money.Name = "Money"
    money.Value = data.Money
    money.Parent = leaderstats
end

function PlayerDataService.InitPlayer(player)
    if profiles[player.UserId] then
        return
    end

    local data = {
        Money = DEFAULT_DATA.Money,
        WorkPower = DEFAULT_DATA.WorkPower,
        PromotionLevel = DEFAULT_DATA.PromotionLevel,
    }

    profiles[player.UserId] = data
    createLeaderstats(player, data)
end

function PlayerDataService.RemovePlayer(player)
    profiles[player.UserId] = nil
end

function PlayerDataService.GetData(player)
    return profiles[player.UserId]
end

function PlayerDataService.TrySpendMoney(player, amount)
    local data = PlayerDataService.GetData(player)
    if not data then
        return false, 0
    end

    if data.Money < amount then
        return false, data.Money
    end

    data.Money -= amount

    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local moneyValue = leaderstats:FindFirstChild("Money")
        if moneyValue then
            moneyValue.Value = data.Money
        end
    end

    return true, data.Money
end

function PlayerDataService.SetWorkPower(player, newWorkPower)
    local data = PlayerDataService.GetData(player)
    if not data then
        return
    end

    data.WorkPower = newWorkPower
end

function PlayerDataService.AddMoney(player, amount)
    local data = PlayerDataService.GetData(player)
    if not data then
        return 0
    end

    data.Money += amount

    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local moneyValue = leaderstats:FindFirstChild("Money")
        if moneyValue then
            moneyValue.Value = data.Money
        end
    end

    return data.Money
end

function PlayerDataService.Start()
    Players.PlayerAdded:Connect(function(player)
        PlayerDataService.InitPlayer(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        PlayerDataService.RemovePlayer(player)
    end)

    for _, player in ipairs(Players:GetPlayers()) do
        PlayerDataService.InitPlayer(player)
    end

    print("[IRONCLAD] PlayerDataService active.")
end

return PlayerDataService
