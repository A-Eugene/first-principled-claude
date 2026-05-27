# First-Principled Claude

This repository contains the configuration and context files for **First-Principled Claude**, a framework designed to override the default sycophantic tendencies of Large Language Models (LLMs) and instill a rigorous, metacognitive, and adversarial problem-solving mindset.

## The First Principle of LLM Persona

LLMs do not have an inherent personality, rigid worldview, or fixed goal state. They operate as sophisticated sequence predictors, adopting the persona, mindset, and implicit goals dictated by the tokens in their context window. 

By default, standard system prompts configure LLMs as "helpful, harmless assistants." While useful for general inquiries, this configuration induces a sycophantic disposition: the model prioritizes agreement over truth, coherence over correctness, and providing an immediate answer over asking load-bearing questions.

To fundamentally change the model's capabilities, we must alter its operating constraints. The files in this repository inject high-density, behavioral constraints directly into the model's context. By defining the rules of engagement, we shift the model's probability distribution away from superficial compliance and toward aggressive, first-principled reasoning.

## Components

### 1. The Kernel: `.claude/CLAUDE.md`
This acts as the base operating system for the model's mindset. It establishes the baseline disposition for all interactions, no matter how trivial.

- **Truth over Agreement:** Instructs the model to disagree with flawed framing and push back on invalid assumptions (*Disagree and Commit*).
- **Constraint Elicitation:** Forbids silent assumptions on load-bearing constraints, forcing the model to ask targeted questions instead of guessing.
- **Verification Posture:** Demands explicit differentiation between conceptual reasoning and empirical verification.
- **Metacognitive Humility:** Forces the model to recognize that "coherence is not correctness" and that its own reasoning process is a potential source of error.

### 2. The Deliberation Protocol: `.claude/commands/deliberate.md`
While `CLAUDE.md` sets the passive mindset, `/deliberate` is the active, heavy-duty iteration engine invoked for complex problems (like deep architectural bugs, system design, or non-trivial planning).

LLMs suffer from **context anchoring**—once they generate a token, it mathematically biases all future tokens. This makes it incredibly difficult for an LLM to organically pivot away from a flawed initial approach. 

The deliberation protocol breaks this anchor through a formal internal loop:
1. **Construct:** Build a solution from first principles and generate meaningful alternatives.
2. **Critically Assess:** Attack the solution aggressively. Treat correctness as unknown. Falsification must have consequences (Patch, Reject, Confirm).
3. **Internal Verdict:** If the foundation is flawed, explicitly declare the premise invalid in context to break the mathematical anchor of previous tokens.
4. **Surface:** Present the final solution alongside a strict, dense **Loop trace**. This trace (detailing the *Approach, Hypothesis, Falsification, and Pivot* for each discarded attempt) provides a transparent, high-density audit of the internal thought process, entirely free of conversational filler.

## Usage

These files are designed to be ingested into the LLM's system prompt or workspace context. 
- For trivial tasks and mechanical edits, the model runs on the `CLAUDE.md` kernel, remaining concise but first-principled. 
- For deep, complex tasks, the user (or the model itself) invokes the `/deliberate` protocol to engage the adversarial iteration loop.
