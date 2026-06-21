local Services = script.Parent:WaitForChild("Services")

local PlayerDataService = require(Services:WaitForChild("PlayerDataService"))
local WorkService = require(Services:WaitForChild("WorkService"))
local PromotionService = require(Services:WaitForChild("PromotionService"))

PlayerDataService.Start()
WorkService.Start()
PromotionService.Start()

print("[IRONCLAD] Main server started.")
