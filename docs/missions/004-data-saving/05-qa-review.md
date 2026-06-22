# 05-qa-review.md

## QA result
PASS

## Files reviewed
- `src/ServerScriptService/IRONCLAD/Services/PlayerDataService.lua`

## Issues found
- None. The save/load implementation meets the mission requirements.

## Required fixes
- None.

## Data safety notes
- All saving/loading is server-side in `PlayerDataService.lua`.
- DataStoreService calls are wrapped in `pcall` for both load and save operations.
- New players receive safe default data when no saved data exists.
- Loaded data is sanitized and invalid values fall back to safe defaults.
- Corrupt or missing saved fields do not propagate into gameplay state.
- Save occurs on player leave and during server shutdown via `game:BindToClose`.

## Roblox Studio test checklist for Commander
1. Open the place in Roblox Studio and run a Local Server + Local Client test.
2. Join as a new player and confirm default money, WorkPower, promotion, and worker values.
3. Earn money, buy promotions, and hire workers.
4. Stop the session or remove the player to trigger save on leave.
5. Restart and rejoin as the same player.
6. Confirm `Money`, `WorkPower`, `PromotionLevel`, and `WorkerCount` match the saved state.
7. Confirm passive income resumes based on the loaded `WorkerCount`.
8. Confirm no offline earnings are granted immediately on rejoin.
9. Confirm WORK still functions and updates money correctly.
10. Confirm Promotions still function and use the loaded promotion state.
11. Confirm Hiring still functions and uses the loaded worker count.
12. Check Server Output for load/save messages like `Loaded data for <PlayerName>.` and `Saved data for <PlayerName>.`.

## Final recommendation
TEST NOW: the Data Saving implementation is ready for QA playtesting.
