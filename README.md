# First-Principled Claude

**Version 2.3**

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
- **Reasoning discipline:** held as *intent, not a fixed sequence* — name a genuine alternative before committing, conclude last, critique adversarially then discount it (anchored), surface the residue. A **de-anchored check** (fresh-context, via a subagent) is mandatory for decisions that are both high-stakes and hard to reverse — and where the harness gates subagents, the harness wins, but the skipped check must be reported rather than silently replaced by same-context critique.
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

## Install

The kernel ships as a skill. Only its description is resident, and the body
loads when substantial work triggers it, or when the load block in "Where it
works" says to. It is skipped on Claude Opus 5.5, where it was measured to add
nothing. Measured against a baseline with no skill on
the same design task: same spec, plus stated assumptions with their inversions,
one alternative rejected on its failure mode, and a line saying the independent
check was not run. The baseline handed over the spec as if it were checked.

Claude Code, Linux or macOS:

```bash
./install.sh
```

Windows: `.\install.ps1`. Both copy, never symlink.

claude.ai: on GitHub, Code › Download ZIP, then upload that zip under
Settings › Customize › Skills. Any paid plan with code execution on. If the
upload rejects the zip, rename the extracted folder to `first-principled` and
zip it again. Skills there are per-user and do not sync from Claude Code, so
re-upload after a change.

Add one line to your always-loaded instructions so the trigger does not depend
on the model noticing:

> For substantial work — a design, an analysis, a decision that is costly to
> reverse — load the `first-principled` skill before proposing an approach.

Section II, Model dispatch, is not in the skill. Effort and thinking are harness
settings, not something a session can act on from a skill body.

## What it feels like in use

- For trivial tasks and mechanical edits, the model stays concise but first-principled.
- For design, architecture, or costly-to-reverse decisions, the kernel's Reasoning discipline engages automatically: alternatives, adversarial self-critique, and an explicit surfacing of flaws, tradeoffs, and unverified assumptions.

## Where it works

A skill's body reaches a session only when the model loads it, so the skill
needs one instruction that is always present. Put this block in your global
instructions: `~/.claude/CLAUDE.md` for Claude Code, Settings › Instructions for
Claude on claude.ai. Keep the lines for the skills you install.

```
## Skills to load
At the start of every turn, if a skill below is not already loaded in this conversation, load it before writing anything, including in resumed conversations and on tasks unrelated to writing.
- plaintalk and house-style: every turn.
- first-principled: only for substantial work (a design, an analysis, a choice between options, a costly decision, a verdict question), and never if you are Claude Opus 5.5.
```

Tested on Claude Code on 2026-10-01: in resumed conversations it loaded
plaintalk and house-style on every turn, and first-principled on a design
question on Claude Opus 5 but not on Claude Opus 5.5.

| Surface | Install | What applies it |
|---|---|---|
| Claude Code | `./install.sh` | The block above in `~/.claude/CLAUDE.md` |
| claude.ai chat and Cowork | Upload a zip of a folder named `first-principled` that holds `SKILL.md`, under Settings › Customize › Skills | The block above in Instructions for Claude |
| Codex | `./install.sh --codex` writes a marked block into `~/.codex/AGENTS.md` | Always in context |
| Gemini CLI | `gemini extensions install https://github.com/A-Eugene/first-principled-claude` | Always in context (context file `SKILL.md`), untested |
