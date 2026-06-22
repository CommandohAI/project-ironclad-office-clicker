# 04-coding-agent-task.md

## Summary of implementation
Implemented a server-side Data Saving System for Project IRONCLAD using Roblox DataStoreService. The system loads player data when they join, saves when they leave, and attempts a final save on server shutdown.

## Files changed
- `src/ServerScriptService/IRONCLAD/Services/PlayerDataService.lua`

## New files created
- None

## How saving works
- `PlayerDataService.SavePlayerData(player)` writes the player’s `Money`, `WorkPower`, `PromotionLevel`, and `WorkerCount` to a DataStore key based on their user ID.
- DataStore calls are wrapped in `pcall` to prevent runtime errors from crashing the server.
- Save failures are logged with `warn` but do not stop gameplay.
- Player data also saves in `game:BindToClose` for server shutdown.

## How loading works
- `PlayerDataService.LoadPlayerData(player)` attempts to read saved data from the same DataStore key.
- If load fails or returns invalid data, the player receives safe default values.
- Loaded values are sanitized to ensure `Money`, `WorkPower`, `PromotionLevel`, and `WorkerCount` are valid numbers.
- The saved data is applied before the player’s game session begins.

## Roblox Studio test steps
1. Open the place in Roblox Studio and run a Local Server + Local Client test.
2. Join as a new player and confirm default values are initialized.
3. Earn money, purchase promotions, and hire workers.
4. Stop the session or leave the player.
5. Rejoin as the same player and confirm loaded values match the saved state.
6. Check the Server Output console for load/save confirmation messages.
7. Confirm WORK, promotions, and hiring continue to function normally after loading.

## Known limitations / follow-up notes
- No offline earnings are granted on load.
- Data is stored under `ProjectIroncladPlayerData` and keyed by `player_<UserId>`.
- The system does not currently retry failed saves beyond the leave/shutdown attempt.
