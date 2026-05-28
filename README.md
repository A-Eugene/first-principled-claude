# First-Principled Claude

**Version 1.0**

This repository contains the configuration and context files for **First-Principled Claude**, a framework designed to override the default sycophantic tendencies of Large Language Models (LLMs) and instill a rigorous, metacognitive, and adversarial problem-solving mindset.

## The First Principle of LLM Persona

LLMs do not have an inherent personality, rigid worldview, or fixed goal state. They operate as sophisticated sequence predictors, adopting the persona, mindset, and implicit goals dictated by the tokens in their context window. 

By default, standard system prompts configure LLMs as "helpful, harmless assistants." While useful for general inquiries, this configuration induces a sycophantic disposition: the model prioritizes agreement over truth, coherence over correctness, and providing an immediate answer over asking load-bearing questions.

To fundamentally change the model's capabilities, we must alter its operating constraints. The files in this repository inject high-density, behavioral constraints directly into the model's context. By defining the rules of engagement, we shift the model's probability distribution away from superficial compliance and toward aggressive, first-principled reasoning.

## Components

### The Kernel: `.claude/CLAUDE.md`
This acts as the base operating system for the model's mindset. It establishes the baseline disposition for all interactions, no matter how trivial.

- **Truth over Agreement:** Instructs the model to disagree with flawed framing and push back on invalid assumptions (*Disagree and Commit*).
- **Constraint Elicitation:** Forbids silent assumptions on load-bearing constraints, forcing the model to ask targeted questions instead of guessing.
- **Verification Posture:** Demands explicit differentiation between conceptual reasoning and empirical verification.
- **Metacognitive Humility:** Forces the model to recognize that "coherence is not correctness," that its own reasoning is a potential source of error, and that its reports about its own process are not guaranteed faithful to it.
- **Reasoning Discipline:** For substantial work — generate a genuinely different alternative before committing, construct then adversarially critique that construction, and surface the residue (flaws, tradeoffs, unverified assumptions).

## Working With Token Conditioning

LLMs exhibit **context anchoring**: once a token is generated, it mathematically conditions every subsequent token. The framework works *with* this mechanism:

- **It steers reasoning at generation time.** Considerations placed into context — alternatives, adversarial critique, surfaced assumptions — shape the tokens that follow. This conditioning is the lever the kernel pulls.
- **It reaches for a fresh context when independence matters.** A genuinely independent check comes from a new context that does not carry the prior reasoning forward, since reasoning already in the window keeps conditioning the output.
- **It constrains what the model emits.** Every instruction targets observable output — what to generate, label, verify, or surface — which is the part of the model that instructions can actually move.

## Usage

These files are designed to be ingested into the LLM's system prompt or workspace context.
- For trivial tasks and mechanical edits, the model stays concise but first-principled.
- For design, architecture, or costly-to-reverse decisions, the kernel's Reasoning discipline engages automatically: alternatives, adversarial self-critique, and an explicit surfacing of flaws, tradeoffs, and unverified assumptions.
