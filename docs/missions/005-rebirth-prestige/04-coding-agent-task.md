# 04-coding-agent-task.md

Summary of what was implemented
- Added a server-authoritative Rebirth / Prestige system.
- Extended player save data to store `Prestige` and `RebirthCount`.
- Implemented `RebirthService` to validate rebirth eligibility, reset current run progress, award prestige, and update the next requirement.
- Added `RebirthController` and client UI elements for opening the rebirth panel, showing prestige, and triggering server-side rebirth.
- Applied prestige as a permanent earnings multiplier for both click income and passive worker income.

Files changed
- `src/ReplicatedStorage/IRONCLAD/Modules/Shared/SignalNames.lua`
- `src/ServerScriptService/IRONCLAD/Main.server.lua`
- `src/ServerScriptService/IRONCLAD/Services/PlayerDataService.lua`
- `src/ServerScriptService/IRONCLAD/Services/WorkService.lua`
- `src/ServerScriptService/IRONCLAD/Services/PromotionService.lua`
- `src/ServerScriptService/IRONCLAD/Services/HiringService.lua`
- `src/StarterGui/MainUI/Main.client.lua`

New files created
- `src/ReplicatedStorage/IRONCLAD/Modules/Config/RebirthConfig.lua`
- `src/ServerScriptService/IRONCLAD/Services/RebirthService.lua`
- `src/StarterGui/MainUI/UIControllers/RebirthController.lua`

How rebirth validation works
- The player requests rebirth through a server RemoteFunction named `RequestRebirth`.
- `RebirthService` checks the player’s current money against the next rebirth requirement.
- If the player has enough money, the server resets Money, PromotionLevel, WorkPower, and WorkerCount.
- Rebirth only happens on the server after this validation.

How prestige bonus works
- Prestige points are stored in player data and persist across saves.
- Each Prestige point adds +1% earnings.
- The bonus multiplies click income and passive worker income.
- WorkService and HiringService both use `PlayerDataService.GetPrestigeMultiplier(player)` to apply the bonus.

How saving/loading was updated
- PlayerDataService now includes `Prestige` and `RebirthCount` in default data and save/load sanitization.
- DataStore save payload now writes `Prestige` and `RebirthCount`.
- Saved prestige loads correctly when the player joins.

Roblox Studio test steps
1. Open the game and enter Play mode.
2. Confirm the Rebirth button appears in the main UI.
3. Verify the Rebirth panel opens and shows `Prestige: 0`, the rebirth requirement, and descriptive bonus text.
4. Earn money until the button becomes enabled.
5. Click Rebirth and confirm money resets to 0, prestige increases by 1, and RebirthCount increments.
6. Confirm the next rebirth requirement updates to the higher threshold.
7. Ensure WORK still earns money and promotions/hiring still function after rebirth.
8. Leave and rejoin, then confirm saved `Prestige` loads and the bonus remains applied.

Known limitations or follow-up notes
- Prestige currently awards a flat +1% earnings per point; future versions can add more depth.
- The UI currently uses a simple panel and does not include a separate confirmation dialog.
- The rebirth flow is intentionally minimal to keep the first version testable and low-risk.
