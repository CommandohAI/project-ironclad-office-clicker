local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerDataService = {}

local profiles = {}
local playerDataStore = DataStoreService:GetDataStore("ProjectIroncladPlayerData")
local RebirthConfig = require(ReplicatedStorage:WaitForChild("IRONCLAD").Modules.Config.RebirthConfig)

local DEFAULT_DATA = {
    Money = 0,
    WorkPower = 1,
    PromotionLevel = 0,
    WorkerCount = 0,
    Prestige = 0,
    RebirthCount = 0,
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

local function sanitizeData(data)
    if type(data) ~= "table" then
        return {
            Money = DEFAULT_DATA.Money,
            WorkPower = DEFAULT_DATA.WorkPower,
            PromotionLevel = DEFAULT_DATA.PromotionLevel,
            WorkerCount = DEFAULT_DATA.WorkerCount,
            Prestige = DEFAULT_DATA.Prestige,
            RebirthCount = DEFAULT_DATA.RebirthCount,
        }
    end

    return {
        Money = tonumber(data.Money) or DEFAULT_DATA.Money,
        WorkPower = tonumber(data.WorkPower) or DEFAULT_DATA.WorkPower,
        PromotionLevel = tonumber(data.PromotionLevel) or DEFAULT_DATA.PromotionLevel,
        WorkerCount = tonumber(data.WorkerCount) or DEFAULT_DATA.WorkerCount,
        Prestige = tonumber(data.Prestige) or DEFAULT_DATA.Prestige,
        RebirthCount = tonumber(data.RebirthCount) or DEFAULT_DATA.RebirthCount,
    }
end

local function getPlayerKey(player)
    return "player_" .. tostring(player.UserId)
end

function PlayerDataService.LoadPlayerData(player)
    local key = getPlayerKey(player)
    local success, result = pcall(function()
        return playerDataStore:GetAsync(key)
    end)

    if not success then
        warn("[IRONCLAD] Failed to load data for " .. player.Name .. ": " .. tostring(result))
        return sanitizeData(nil)
    end

    if type(result) ~= "table" then
        print("[IRONCLAD] No saved data for " .. player.Name .. "; using defaults.")
        return sanitizeData(nil)
    end

    local sanitized = sanitizeData(result)
    print("[IRONCLAD] Loaded data for " .. player.Name .. ".")
    return sanitized
end

function PlayerDataService.SavePlayerData(player)
    local data = PlayerDataService.GetData(player)
    if not data then
        warn("[IRONCLAD] No profile data to save for " .. player.Name)
        return false
    end

    local key = getPlayerKey(player)
    local saveData = {
        Money = data.Money,
        WorkPower = data.WorkPower,
        PromotionLevel = data.PromotionLevel,
        WorkerCount = data.WorkerCount,
        Prestige = data.Prestige,
        RebirthCount = data.RebirthCount,
    }

    local success, result = pcall(function()
        playerDataStore:SetAsync(key, saveData)
    end)

    if success then
        print("[IRONCLAD] Saved data for " .. player.Name .. ".")
        return true
    else
        warn("[IRONCLAD] Failed to save data for " .. player.Name .. ": " .. tostring(result))
        return false
    end
end

function PlayerDataService.LoadOrCreateProfile(player)
    if profiles[player.UserId] then
        return
    end

    local data = PlayerDataService.LoadPlayerData(player)
    profiles[player.UserId] = data
    createLeaderstats(player, data)
end

function PlayerDataService.InitPlayer(player)
    if profiles[player.UserId] then
        return
    end

    local data = {
        Money = DEFAULT_DATA.Money,
        WorkPower = DEFAULT_DATA.WorkPower,
        PromotionLevel = DEFAULT_DATA.PromotionLevel,
        WorkerCount = DEFAULT_DATA.WorkerCount,
        Prestige = DEFAULT_DATA.Prestige,
        RebirthCount = DEFAULT_DATA.RebirthCount,
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

function PlayerDataService.GetPrestigeMultiplier(player)
    local data = PlayerDataService.GetData(player)
    if not data then
        return 1
    end

    local prestige = tonumber(data.Prestige) or 0
    return 1 + (prestige * RebirthConfig.prestigeBonusPercent)
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
        PlayerDataService.LoadOrCreateProfile(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        PlayerDataService.SavePlayerData(player)
        PlayerDataService.RemovePlayer(player)
    end)

    for _, player in ipairs(Players:GetPlayers()) do
        PlayerDataService.LoadOrCreateProfile(player)
    end

    game:BindToClose(function()
        for userId, data in pairs(profiles) do
            local key = "player_" .. tostring(userId)
            local success, result = pcall(function()
                playerDataStore:SetAsync(key, {
                    Money = data.Money,
                    WorkPower = data.WorkPower,
                    PromotionLevel = data.PromotionLevel,
                    WorkerCount = data.WorkerCount,
                    Prestige = data.Prestige,
                    RebirthCount = data.RebirthCount,
                })
            end)

            if success then
                print("[IRONCLAD] Saved data for user " .. tostring(userId) .. " on shutdown.")
            else
                warn("[IRONCLAD] Failed to save data for user " .. tostring(userId) .. " on shutdown: " .. tostring(result))
            end
        end
    end)

    print("[IRONCLAD] PlayerDataService active.")
end

return PlayerDataService
