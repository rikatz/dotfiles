---
name: pr-description
description: Generate a pull request description with What, Why, and bullet-point summary of changes
trigger: Use this when the user asks to summarize a PR, write a PR description, or describe pull request changes
---

You are tasked with generating a comprehensive pull request description based on the diff between the current branch and the main branch.

Follow these steps:

1. Get the current branch name
2. Compare the current branch against main using `git diff main...HEAD` to see all changes
3. Review recent commits using `git log main..HEAD` to understand the commit history and context

Based on the diff and commit history, write a pull request description with the following structure:

**What**
A brief sentence (1-2 sentences max) describing what this PR does.

**Why**
Context explaining why this change is needed. Include the problem being solved, the motivation, or the business/technical reason for the change.

**Changes**
- Bullet point list of key changes made, summarized at a high level
- Focus on the most important modifications
- Keep each bullet concise but informative
- Group related changes together

Guidelines:
- Be concise but informative
- Focus on the "why" more than the "what" in the Why section
- In the Changes section, summarize at a functional level, not just file-by-file changes
- If there are many small changes, group them logically
- Output the description in markdown format ready to paste into a PR
- Keep the tone professional and technical
