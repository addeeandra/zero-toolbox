# Zeroclaw Toolbox

Harnessing environment for Zeroclaw agents.

### What is it?

One of the challenge in agentic ai is their environments. Environment allow llm to verify their work by searching to internet, linting, testing, or simulating by running multiple tools. Proper environment allows an agent to have deterministic factor, reducing hallucination and allowing them to have abilities to verify their actual works in shorter feedback loops.

For example, as a Laravel developer, we utilize several tools, allowing us to write robust, safe, and durable code. Laravel developers use tools such as Pest for testing, Phpstan as linter, Dusk + Playwright to tests ui, Sqlite/Mysql/Postgres for database, and more. On the other hand, Flutter developer use dart and flutter cli to verify their works. Both cases require different environments.

Common pitfall in ai assistaed work is we allow the ai agent to have `sudo` access to execute all commands. This practice has serious concern regarding security and especially accidental actions by the llm. Of course we regret it after it drop our databases or run `rm -rf` to our workspace folders.

I picked Zeroclaw because it has strong and safety-first guardrails, allowing me to expand the capabilities further in iterative manner.

### Current Environment

- Laravel Agent

### How to setup

> You nede to brings your own key. (BYOK)

1. Install Docker
2. Copy `.env.example` to `.env` and set `MODEL`, `PROVIDER`, and `API_KEY` of your choice.
3. Just run `./spin-laravel.sh` (for now I have only this)