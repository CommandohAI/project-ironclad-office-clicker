# 05-qa-review.md

## QA result
PASS

## Files reviewed
- `src/ServerScriptService/IRONCLAD/Services/PlayerDataService.lua`
- `src/ServerScriptService/IRONCLAD/Services/HiringService.lua`
- `src/ServerScriptService/IRONCLAD/Main.server.lua`
- `src/StarterGui/MainUI/UIControllers/HiringController.lua`
- `src/StarterGui/MainUI/Main.client.lua`
- `src/ReplicatedStorage/IRONCLAD/Modules/Shared/SignalNames.lua`

## Issues found
- No remaining mission-critical issues were found in the corrected Hiring implementation.

## Required fixes
- None.

## Security notes
- The Hiring system remains server-authoritative: money checks and worker purchases occur only on the server.
- The client does not directly mutate money, worker count, or passive income values.
- Remote functions are used consistently for hiring data and purchase requests.

## Roblox Studio test checklist for Commander
1. Open the place in Roblox Studio and run a local client test.
2. Confirm the Hiring button is visible in the Main UI.
3. Press Hiring and verify the Hiring panel opens.
4. Confirm the panel shows worker name, count, cost, income per worker, and total income per second.
5. Press WORK until money reaches at least £20.
6. Press Hire and confirm the worker count increases and the next cost updates.
7. Confirm the total income/sec updates in the Hiring panel.
8. Confirm the main money display updates immediately after purchase.
9. Watch the main money display for at least 3 seconds and confirm passive income increases it automatically.
10. Verify the Hire button disables with insufficient funds and the message `Not enough money` appears.
11. Confirm the Promotions panel still opens, closes, and purchases promotions as before.
12. Confirm the WORK button still awards money and updates the display.

## Final recommendation
TEST NOW: the corrected Hiring implementation is ready for a full QA playtest.
