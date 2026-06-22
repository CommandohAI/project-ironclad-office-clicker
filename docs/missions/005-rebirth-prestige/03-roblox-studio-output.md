# 03-roblox-studio-output.md

Required UI behaviour
- Add a Rebirth panel to the existing main UI, visible alongside the work, promotions, and hiring panels.
- Show the current Prestige total and the current rebirth money requirement.
- Disable the Rebirth button until the player has enough money.
- Enable the button and update requirement text when the player reaches the threshold.
- After a successful rebirth, update the displayed Prestige amount and reset the displayed money, promotion, and worker values.

Required Explorer structure
- `StarterGui/MainUI` should contain a new `Frame` or `TextButton` named `RebirthPanel`.
- Inside `RebirthPanel`, include:
  - `PrestigeLabel` (TextLabel)
  - `RequirementLabel` (TextLabel)
  - `RebirthButton` (TextButton)
  - Optional `DescriptionLabel` (TextLabel) for bonus text.
- The new UI should be accessible from `StarterGui/MainUI/Main.client.lua` and `UIControllers`.

Required buttons, labels, frames, and visual elements
- `RebirthPanel` frame:
  - `PrestigeLabel`: shows `Prestige: 0` initially.
  - `RequirementLabel`: shows `Rebirth requires 10,000 money` or similar.
  - `RebirthButton`: labeled `Rebirth` or `Reset for Prestige`.
  - `DescriptionLabel`: short text like `+1% earnings per Prestige point`.
- The button should have a disabled appearance when not eligible.
- The panel should be sized and placed to fit the current UI layout without cluttering.

What happens when the player presses the Rebirth button/panel
- If eligible, the button sends a rebirth request to the server.
- If not eligible, the button remains disabled and does nothing.
- If the server rejects the request, show no gameplay change and keep the requirement text visible.

What happens when the player rebirths successfully
- The UI resets money display to `0`.
- Promotion and worker-related displays return to base values.
- The Prestige label updates to the new total.
- The requirement label updates to the next rebirth threshold.
- The Rebirth button becomes disabled again until the new threshold is reached.

What happens when the player cannot rebirth yet
- The Rebirth button stays disabled.
- The requirement label continues showing the current target.
- The UI may display a message like `Earn more money to unlock Rebirth.`
- The player can still use the existing work, promotions, and hiring systems.

How prestige should appear/update
- Display Prestige as a persistent counter in the Rebirth panel.
- Update the label instantly after a successful rebirth.
- Preserve the Prestige total across game reloads via saved data.
- If desired, show the Prestige multiplier in the description: `+X% earnings`.

What should save/load after rebirth
- Save and load the Prestige total with the existing player profile.
- After loading, the UI should show the saved Prestige value and apply the earned bonus.
- The rebirth requirement should be recalculated from the current saved milestone state.

What the Commander should see after implementation
- In Roblox Studio Play mode, a Rebirth panel appears in the main game UI.
- The panel shows current Prestige, the next rebirth requirement, and a disabled Rebirth button until eligible.
- After meeting the requirement and clicking Rebirth, the button triggers a reset and the Prestige total increases.
- The existing Money, promotion, and hiring displays reset to the starting state.

Roblox Studio test steps
1. Open the game in Roblox Studio and start Play mode.
2. Confirm the new `RebirthPanel` exists under `StarterGui/MainUI`.
3. Check the panel shows `Prestige: 0`, the requirement text, and a disabled button.
4. Earn money until the displayed money reaches the rebirth threshold.
5. Verify the Rebirth button becomes enabled and the requirement text updates to indicate eligibility.
6. Click Rebirth and confirm money resets to `0`, Prestige increases by `1`, and the button disables again.
7. Verify the next rebirth requirement displays the new target.
8. Close and reopen the game to confirm Prestige persists and the UI loads the saved Prestige value.

Handoff task for Coding Agent
- Add the Rebirth UI objects to `StarterGui/MainUI` and connect them in `Main.client.lua`.
- Implement client-server rebirth requests and eligibility updates.
- Ensure Prestige saves and loads with the existing player data system.
- Keep the Rebirth panel simple and consistent with the current interface.
