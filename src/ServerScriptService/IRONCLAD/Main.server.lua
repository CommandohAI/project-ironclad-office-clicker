local Services = script.Parent:WaitForChild("Services")

local PlayerDataService = require(Services:WaitForChild("PlayerDataService"))
local WorkService = require(Services:WaitForChild("WorkService"))
local PromotionService = require(Services:WaitForChild("PromotionService"))
local HiringService = require(Services:WaitForChild("HiringService"))
local RebirthService = require(Services:WaitForChild("RebirthService"))
local MonetisationService = require(Services:WaitForChild("MonetisationService"))

PlayerDataService.Start()
WorkService.Start()
PromotionService.Start()
HiringService.Start()
RebirthService.Start()
MonetisationService.Start()

print("[IRONCLAD] Main server started.")
