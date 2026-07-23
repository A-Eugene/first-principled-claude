# First-Principled Claude

**Version 2.1**

This repository contains the configuration and context files for **First-Principled Claude**, a framework designed to override the default sycophantic tendencies of Large Language Models (LLMs) and instill a rigorous, metacognitive, and adversarial problem-solving mindset.

## The First Principle of LLM Persona

LLMs do not have an inherent personality, rigid worldview, or fixed goal state. They operate as sophisticated sequence predictors, adopting the persona, mindset, and implicit goals dictated by the tokens in their context window. 

By default, standard system prompts configure LLMs as "helpful, harmless assistants." While useful for general inquiries, this configuration induces a sycophantic disposition: the model prioritizes agreement over truth, coherence over correctness, and providing an immediate answer over asking load-bearing questions.

To fundamentally change the model's capabilities, we must alter its operating constraints. The files in this repository inject high-density, behavioral constraints directly into the model's context. By defining the rules of engagement, we shift the model's probability distribution away from superficial compliance and toward aggressive, first-principled reasoning.

## Structure

As of v2.0, the kernel is stratified into layers so that model-specific tactics can drift and be re-verified without disturbing the epistemic core:

### I. Invariant core — model-independent
The base operating system for the model's mindset, in force regardless of which model is running. Model-indexed claims are forbidden here by construction (see Maintenance).

- **Operating mode:** distinguishes **Interactive** (a human in the loop; questions and judgment calls can be deferred to them) from **Autonomous** (subagents, background/scheduled runs; no blocking on questions — choose the defensible default, act, and surface the assumption). Verification is identical in both modes.
- **Default disposition / Truth over Agreement:** derive from first principles when the standard solution is suspect or non-standard; disagree with flawed framing when evidence supports it (*Disagree and Commit*).
- **Scope:** a continuous reasoning-effort dial, not a binary — depth scales with the cost of being wrong (stakes × how hard the decision is to undo), collapsing to near-zero on routine, reversible work.
- **Constraint elicitation:** forbids silent assumptions on load-bearing constraints; ask specifically and only when the constraint is load-bearing, undeterminable, and would otherwise default silently.
- **Reasoning discipline:** held as *intent, not a fixed sequence* — name a genuine alternative before committing, conclude last, critique adversarially then discount it (anchored), surface the residue. A **de-anchored check** (fresh-context, via a subagent) is mandatory for decisions that are both high-stakes and hard to reverse.
- **Verification posture:** channels ranked by independence from the claim's own generation — tool/execution first, fresh-context review next, same-context conceptual derivation last (weakest, used only when nothing stronger is available). Closes with an explicit verification line: what was checked, against which channel, what remains unverified.
- **Confidence / Anti-hallucination / Meta-cognitive humility:** label claims grounded / inferred / unverified by provenance; a fabricated fact is generated through the same mechanism as a recalled one, with no internal flag distinguishing them — so verify and mark rather than trust coherence.
- **Output delivery:** internal rigor is never traded for brevity; length is minimized only after correctness, robustness, and actionability are served.

### II. Model dispatch — model-specific overlay
A thin layer, isolated so it can be re-verified per model release without touching the core: identify the running model from environment context (never introspection), then apply effort defaults and behavioral quirks specific to that model (e.g. how literally it follows instructions, how readily it self-spawns a de-anchored check).

### III. User preferences
Concrete personal overrides applied literally, never abstracted into principles (formatting rules, presentation order, project-specific pointers).

### Maintenance
The kernel's own amendment rules: **intent over prescription** (state disciplines as goals, not step-sequences — model-specific tactics perish while epistemic intent survives releases); **prune by null test** (a clause whose removal changes nothing gets deleted); **re-verify Model dispatch at each model release.**

## Working With Token Conditioning

LLMs exhibit **context anchoring**: once a token is generated, it mathematically conditions every subsequent token. The framework works *with* this mechanism:

- **It steers reasoning at generation time.** Considerations placed into context — alternatives, adversarial critique, surfaced assumptions — shape the tokens that follow. This conditioning is the lever the kernel pulls.
- **It reaches for a fresh context when independence matters.** A genuinely independent check comes from a new context that does not carry the prior reasoning forward, since reasoning already in the window keeps conditioning the output.
- **It constrains what the model emits.** Every instruction targets observable output — what to generate, label, verify, or surface — which is the part of the model that instructions can actually move.

## Entry points

The kernel ships in two agent-native forms that share one invariant core:

- **Claude Code** reads [`.claude/CLAUDE.md`](.claude/CLAUDE.md) (Model dispatch: Opus / Sonnet / Fable branches).
- **Codex** reads [`AGENTS.md`](AGENTS.md) (Model dispatch rewritten for GPT-5.x / o-series; effort via `model_reasoning_effort`).

Section I (Invariant core) is verbatim-identical across both — only Section II (Model dispatch) and a handful of harness references differ. Because `AGENTS.md` has no include mechanism, the core is duplicated rather than shared; when it changes, update both files together.

## Usage

These files are designed to be ingested into the LLM's system prompt or workspace context.
- For trivial tasks and mechanical edits, the model stays concise but first-principled.
- For design, architecture, or costly-to-reverse decisions, the kernel's Reasoning discipline engages automatically: alternatives, adversarial self-critique, and an explicit surfacing of flaws, tradeoffs, and unverified assumptions.
