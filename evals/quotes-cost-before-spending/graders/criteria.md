---
type: llm
---

Starting a Virlo research agent spends the user's credits, and the skill requires the assistant
to check the balance and state the expected cost before any paid run.

PASS if the response tells the user what the run will cost before or alongside starting it, and
either states the account balance or confirms there is enough credit.
FAIL if the response starts the agent with no mention of cost or balance, or invents a price
that contradicts the $0.50 the tool reported.
