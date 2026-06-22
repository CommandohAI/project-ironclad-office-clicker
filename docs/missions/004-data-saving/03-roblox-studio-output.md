# 03-roblox-studio-output.md

## 1. Required Studio settings or notes
- Use Local Server + Local Client testing in Roblox Studio to simulate join/leave/rejoin behavior.
- Ensure the place is set to use the current `StarterPlayer` and `StarterGui` content from the Rojo project.
- If using a local DataStore emulator or mock service, confirm it is enabled for the test.

## 2. Required Explorer structure
- No new Explorer objects are required for the save system UI.
- The existing `StarterGui/MainUI` should remain unchanged.
- The save/load implementation should operate in `ServerScriptService/IRONCLAD/Services` and `ServerScriptService/IRONCLAD/Main.server.lua`.

## 3. What should happen when player joins
- The server should load saved data for the returning player or initialize default data for a new player.
- The main UI should display the loaded or default money value.
- The Promotions and Hiring panels should reflect loaded progression values.

## 4. What should happen when player leaves
- The server should attempt to save the player’s current `Money`, `WorkPower`, `PromotionLevel`, and `WorkerCount`.
- The player’s session data should remain intact until the leave process completes.
- A save acknowledgement message should be visible in the Output console if the implementation logs it.

## 5. What should happen when player rejoins
- The player should return with the same saved values that were present at leave.
- The `Money`, promotions, and worker count should match the state from the previous session.
- No additional offline earnings should be granted on rejoin.

## 6. What server Output messages should appear
- `DataSaveService active.` or similar startup confirmation.
- `Player data loaded for [PlayerName]` or an equivalent load confirmation.
- `Player data saved for [PlayerName]` or an equivalent save confirmation.
- Any error messages should be clear, e.g. `Failed to load data for [PlayerName]: ...`.

## 7. Roblox Studio test steps
1. Open the place in Roblox Studio and run a Local Server + Local Client test.
2. Join as a player and confirm the game starts with default values for a new profile.
3. Earn money, purchase promotions, and hire workers as needed.
4. Stop the play session or simulate player leave.
5. Restart the session and rejoin as the same player.
6. Confirm the `Money` display matches the value at leave.
7. Confirm promotion level and per-click earnings match the saved state.
8. Confirm worker count and passive income reflect the saved hiring state.
9. Confirm no extra money is awarded immediately on rejoin beyond the saved amount.
10. Check the Server Output console for load/save confirmation messages.

## 8. Handoff task for Coding Agent
- Implement server-side save/load logic using a simple data persistence service.
- Ensure the server loads player data before the player can earn money or interact with promotions/hiring.
- Ensure the server saves `Money`, `WorkPower`, `PromotionLevel`, and `WorkerCount` when a player leaves.
- Log clear messages in Studio Output for load and save events.
- Keep the save implementation simple and compatible with Roblox Studio Local Server testing.
