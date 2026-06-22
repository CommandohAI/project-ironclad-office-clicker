# 01-game-design-output.md

Gameplay purpose
- Introduce a simple long-term loop by letting players reset progress in exchange for permanent Prestige/Coporate Influence.
- Provide a clear reward for reaching a high money milestone and encourage replay through permanent earning boosts.
- Make Prestige feel like a meaningful meta-progression layer without adding complex systems.

Player flow
1. Player earns money through work, promotions, and passive workers.
2. When money reaches the rebirth requirement, the Rebirth panel becomes available.
3. Player opens the Rebirth panel and reviews current Prestige and the required money threshold.
4. Player confirms rebirth.
5. Game resets the current run progress and awards permanent Prestige.
6. Player starts a new run with the Prestige bonus active and can repeat once the threshold is met again.

Rebirth behaviour
- Rebirth is an explicit reset action triggered by the player.
- Rebirth is only allowed when the player has at least the required money amount.
- Rebirth resets the current run state and awards permanent Prestige that persists across sessions.
- The player keeps their Prestige total after rebirth and gains an earnings bonus for future runs.

What resets on rebirth
- Money becomes 0.
- PromotionLevel resets to the base level.
- WorkPower resets to the base starting click power.
- WorkerCount resets to 0.
- Any current run-only metrics are cleared.

What stays after rebirth
- Total Prestige / Corporate Influence.
- Prestige-based permanent bonus.
- Player progress save data that includes Prestige.
- Any non-run-specific meta state required for future play.

Prestige reward behaviour
- Each rebirth grants a fixed Prestige reward, such as 1 Prestige point per rebirth.
- Prestige points provide a simple permanent bonus, for example +1% earnings per Prestige point.
- The bonus increases future money gains from work and passive income.
- The reward is easy to understand and visible in the UI.

UI behaviour
- Add a Rebirth panel with:
  - Current Prestige amount.
  - Current money amount and rebirth requirement.
  - A Rebirth button.
  - A short description of the permanent earnings bonus.
- The Rebirth button is disabled until the player meets the money requirement.
- When eligible, the requirement text should clearly show that rebirth is available.
- After rebirth, the UI updates to show Money 0, PromotionLevel reset, WorkerCount 0, and the updated Prestige total.

What happens when the player cannot rebirth yet
- The Rebirth button remains disabled.
- The panel shows the current money and the required money threshold.
- A short tooltip or label explains "Earn X more money to unlock Rebirth." or similar messaging.
- The player continues using the existing work, promotion, and hiring loops until eligible.

Acceptance criteria
- The Game Design output is written in `docs/missions/005-rebirth-prestige/01-game-design-output.md`.
- The design is simple and suitable for a first playable Rebirth system.
- The Rebirth flow, reset behavior, permanence, and prestige bonus are clearly described.
- The system does not require monetisation, skill trees, shops, offline earnings, or admin tools.
- The UI behavior is specified enough for economy and coding handoff.

Handoff task for Economy Agent
- Define the rebirth money requirement and Prestige reward values for the first version.
- Specify how Prestige scales the permanent bonus, including whether it applies to both click earnings and passive worker income.
- Recommend a balanced initial rebirth threshold that is reachable but meaningful.

Handoff task for Coding Agent
- Implement the Rebirth interface, eligibility check, and reset behavior.
- Save and load Prestige data together with existing progress.
- Provide a server-authoritative Rebirth action with clear success/failure responses.
- Update the UI to show current Prestige, the rebirth requirement, and button disabled/eligible state.
