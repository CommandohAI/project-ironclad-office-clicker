# 02-economy-output.md

## 1. First worker type name
Junior Worker

## 2. Starting worker cost
20

## 3. Worker income per second
1

## 4. Cost scaling formula
Use a simple multiplicative scaling formula:
- cost(next) = round(cost(current) * 1.4)
- Keep values whole and easy to display.

## 5. Suggested first 10 worker costs
1. 20
2. 28
3. 39
4. 55
5. 77
6. 108
7. 151
8. 212
9. 297
10. 416

## 6. Suggested first 10 passive income values
Each Junior Worker gives 1 passive income per second.
- 1 worker: 1/sec
- 2 workers: 2/sec
- 3 workers: 3/sec
- 4 workers: 4/sec
- 5 workers: 5/sec
- 6 workers: 6/sec
- 7 workers: 7/sec
- 8 workers: 8/sec
- 9 workers: 9/sec
- 10 workers: 10/sec

## 7. Early-game pacing target
- The first worker should feel attainable after about 20 active WORK clicks if the player has not bought too many promotions.
- Passive income should feel useful but still slower than a steady click pace early on.
- At 2–3 workers, the player should notice a visible additional income stream, but clicking should remain the fastest way to earn until more workers are bought.

## 8. What happens if the player cannot afford a worker
- The purchase is blocked.
- The buy button should be disabled or clearly labeled as unavailable.
- No money should be deducted and no worker count should change.
- The UI can show a simple message like “Not enough money” when the player attempts purchase without funds.

## 9. Economy handoff task for Coding Agent
- Implement the worker purchase system using the following values:
  - `baseWorkerCost = 20`
  - `workerIncomePerSecond = 1`
  - `costScaleFactor = 1.4`
- Use integer currency and round costs to whole numbers after scaling.
- Validate purchases server-side: check `playerMoney >= workerCost`, deduct cost, increment worker count, and return updated money and passive income.
- Ensure the UI receives current worker count, current cost, income per second, and total passive income per second.
- Ensure the buy button is disabled when the player cannot afford the current worker cost.
