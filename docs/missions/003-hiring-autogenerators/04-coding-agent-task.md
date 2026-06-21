# 04-coding-agent-task.md

## Summary of implementation
Implemented a simple Hiring / Autogenerators system that allows players to open a Hiring panel, buy workers, and earn passive income every second.

## Files changed
- `src/ReplicatedStorage/IRONCLAD/Modules/Config/HiringConfig.lua`
- `src/ReplicatedStorage/IRONCLAD/Modules/Shared/SignalNames.lua`
- `src/ServerScriptService/IRONCLAD/Services/PlayerDataService.lua`
- `src/ServerScriptService/IRONCLAD/Services/HiringService.lua`
- `src/ServerScriptService/IRONCLAD/Main.server.lua`
- `src/StarterGui/MainUI/UIControllers/HiringController.lua`
- `src/StarterGui/MainUI/Main.client.lua`

## New files created
- `src/ReplicatedStorage/IRONCLAD/Modules/Config/HiringConfig.lua`
- `src/ServerScriptService/IRONCLAD/Services/HiringService.lua`
- `src/StarterGui/MainUI/UIControllers/HiringController.lua`

## Roblox Studio test steps
1. Open the place in Roblox Studio and run a local client test.
2. Confirm the Hiring button is visible in the Main UI.
3. Press Hiring to open the Hiring panel.
4. Verify the panel shows `Junior Worker`, `Owned`, `Cost`, `Income / worker`, and total `Income / sec`.
5. Press WORK repeatedly until money reaches at least £20.
6. Press Hire to buy a worker.
7. Confirm money decreases by the worker cost, worker count increases, and the total income/sec updates.
8. Observe the money display for a few seconds and confirm passive income adds automatically.
9. Verify the Hire button disables if the player cannot afford the next worker, and the message `Not enough money` appears.
10. Confirm the Promotions panel still opens, closes, and purchases promotions as before.

## Known limitations / follow-up notes
- Worker data is not saved between sessions.
- Only one worker tier is implemented for first-version simplicity.
- Passive income is generated on the server once per second and updates the Hiring panel each tick.
- If the player opens the Hiring panel, the UI refreshes from the server, but the panel does not yet animate beyond a simple toggle.

## Correction Notes
- Fixed the Hiring system so the server now fires `MoneyUpdated` after passive income is applied.
- Fixed the Hiring purchase flow so the server also fires `MoneyUpdated` after a successful worker purchase.
- This ensures the main money display updates correctly without relying on panel refresh alone.
