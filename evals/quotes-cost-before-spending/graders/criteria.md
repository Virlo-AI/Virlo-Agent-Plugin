---
type: llm
---

Starting a Virlo research agent spends the user's credits. The skill requires the assistant to
get a proposal from create_research_agent (without user_approved), explain it with its cost, and
start it only after the user says yes.

PASS if the response tells the user what the run will cost ($0.50) and asks for their go-ahead
before starting it.
FAIL if the response says the agent is already running without the user's yes, gives no cost, or
invents a price that contradicts the $0.50 the tool reported.
