# First-Principled Claude

**Version 2.2**

This repository contains the configuration and context files for **First-Principled Claude**, a framework designed to override the default sycophantic tendencies of Large Language Models (LLMs) and instill a rigorous, metacognitive, and adversarial problem-solving mindset.

## The First Principle of LLM Persona

LLMs do not have an inherent personality, rigid worldview, or fixed goal state. They operate as sophisticated sequence predictors, adopting the persona, mindset, and implicit goals dictated by the tokens in their context window. 

By default, standard system prompts configure LLMs as "helpful, harmless assistants." While useful for general inquiries, this configuration induces a sycophantic disposition: the model prioritizes agreement over truth, coherence over correctness, and providing an immediate answer over asking load-bearing questions.

To fundamentally change the model's capabilities, we must alter its operating constraints. The files in this repository inject high-density, behavioral constraints directly into the model's context. By defining the rules of engagement, we shift the model's probability distribution away from superficial compliance and toward aggressive, first-principled reasoning.

## Structure

The kernel is stratified into layers so that model-specific tactics can drift and be re-verified without disturbing the epistemic core. A third layer — your own preferences — lives outside this repo, in the `CLAUDE.md` that imports it (see Installation):

### I. Invariant core — model-independent
The base operating system for the model's mindset, in force regardless of which model is running. Model-indexed claims are forbidden here by construction (see Maintenance).

- **Operating mode:** distinguishes **Interactive** (a human in the loop; questions and judgment calls can be deferred to them) from **Autonomous** (subagents, background/scheduled runs; no blocking on questions — choose the defensible default, act, and surface the assumption). Verification is identical in both modes.
- **Default disposition / Truth over Agreement:** derive from first principles when the standard solution is suspect or non-standard; disagree with flawed framing when evidence supports it (*Disagree and Commit*).
- **Scope:** a continuous reasoning-effort dial, not a binary — depth scales with the cost of being wrong (stakes × how hard the decision is to undo), collapsing to near-zero on routine, reversible work.
- **Constraint elicitation:** forbids silent assumptions on load-bearing constraints — a default that merely *sounds* coherent is not a determined one, so don't presume it. Ask only when the constraint is load-bearing, undeterminable, and would otherwise default silently; when you ask, present the options you're weighing with a recommendation ("A (faster, rough) or B (slower, exact)? I lean A because…") rather than a bare "any preferences?". In Autonomous mode, act on the most defensible default and surface the alternatives rejected.
- **Reasoning discipline:** held as *intent, not a fixed sequence* — name a genuine alternative before committing, conclude last, critique adversarially then discount it (anchored), surface the residue. A **de-anchored check** (fresh-context, via a subagent) is mandatory for decisions that are both high-stakes and hard to reverse.
- **Verification posture:** channels ranked by independence from the claim's own generation — tool/execution first, fresh-context review next, same-context conceptual derivation last (weakest, used only when nothing stronger is available). Closes with an explicit verification line: what was checked, against which channel, what remains unverified.
- **Confidence / Anti-hallucination / Meta-cognitive humility:** label claims grounded / inferred / unverified by provenance; a fabricated fact is generated through the same mechanism as a recalled one, with no internal flag distinguishing them — so verify and mark rather than trust coherence.
- **Output delivery:** internal rigor is never traded for brevity; length is minimized only after correctness, robustness, and actionability are served.

### II. Model dispatch — model-specific overlay
A thin layer, isolated so it can be re-verified per model release without touching the core: identify the running model from environment context (never introspection), then apply effort defaults and behavioral quirks specific to that model (e.g. how literally it follows instructions, how readily it self-spawns a de-anchored check).

### Maintenance
The kernel's own amendment rules: **intent over prescription** (state disciplines as goals, not step-sequences — model-specific tactics perish while epistemic intent survives releases); **prune by null test** (a clause whose removal changes nothing gets deleted); **re-verify Model dispatch at each model release.**

## Working With Token Conditioning

LLMs exhibit **context anchoring**: once a token is generated, it mathematically conditions every subsequent token. The framework works *with* this mechanism:

- **It steers reasoning at generation time.** Considerations placed into context — alternatives, adversarial critique, surfaced assumptions — shape the tokens that follow. This conditioning is the lever the kernel pulls.
- **It reaches for a fresh context when independence matters.** A genuinely independent check comes from a new context that does not carry the prior reasoning forward, since reasoning already in the window keeps conditioning the output.
- **It constrains what the model emits.** Every instruction targets observable output — what to generate, label, verify, or surface — which is the part of the model that instructions can actually move.

## Installation

**The kernel is not a `CLAUDE.md` — it is meant to be *imported* by yours.** It carries no personal preferences (as of v2.2 those were stripped out), so it composes: your `CLAUDE.md` stays a short, personal file, and the kernel is a versioned dependency you can update by pulling this repo.

### Claude Code

Drop [`first-principled-claude.md`](first-principled-claude.md) next to your `CLAUDE.md` (globally, `~/.claude/`; or per-project) and import it at the top with an `@` line:

```markdown
@first-principled-claude.md

---

# User preferences

- **No LaTeX.** Plain Unicode math.
- ... your own overrides here ...
```

Claude Code resolves `@path` imports relative to the importing file and inlines them into context. Ordering matters in the useful direction: the kernel loads first, your preferences follow as literal overrides on top of it.

Why import rather than paste:
- **Separation by change rate.** Preferences are personal and stable; the kernel is versioned and evolves per model release. Different lifetimes, different files.
- **Updates are a `git pull`,** not a hand-merge into a file you have since edited.

### Codex

Codex has **no include mechanism** — `AGENTS.md` must be self-contained. Use [`AGENTS.md`](AGENTS.md) directly as (or appended to) your `~/.codex/AGENTS.md`, and append your own preferences to the end of it.

### What differs between the two

Section I (Invariant core) is verbatim-identical across `first-principled-claude.md` and `AGENTS.md`. Only Section II (Model dispatch — Opus/Sonnet/Fable vs. GPT-5.x/o-series, effort via `model_reasoning_effort`) and a handful of harness references differ. Because of the missing include mechanism the core is duplicated, so when it changes, update both files together.

## What it feels like in use

- For trivial tasks and mechanical edits, the model stays concise but first-principled.
- For design, architecture, or costly-to-reverse decisions, the kernel's Reasoning discipline engages automatically: alternatives, adversarial self-critique, and an explicit surfacing of flaws, tradeoffs, and unverified assumptions.
