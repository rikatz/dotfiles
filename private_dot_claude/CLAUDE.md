# Global Engineering Standards (OpenShift & Golang)

## Agentic Protocol (The.GCC Protocol)
1. **Plan First**: All tasks MUST start with `@architect` generating a `plan.md` in the project-local `.GCC/branches/<task-name>/` directory.[1, 2]
2. **Rationale Persistence**: Agents MUST append their "Observation-Thought-Action" (OTA) reasoning to `.GCC/branches/<task-name>/log.md`.[1, 3]
3. **Verification**: Implementation is not complete until verified by `@qa` and `@security` using the mandatory structured review format.
4. **Handoff Summary**: When switching agents, the summary MUST include any discovered environment quirks or dependency flags to save tokens.

## Golang & Kubernetes Standards
- **Context Management**: Every blocking operation (API calls, I/O) MUST accept and respect `context.Context` .
- **Logging**: Use structured KV pairs (e.g., `logger.Info("Created Pod", "name", pod.Name)`). Messages start with a Capital letter, no ending period .
- **OpenShift API Rules**: NO BOOLEAN FIELDS in CRDs. Use Enums for states .
- **Idempotency**: Reconcilers MUST be idempotent and handle `ResourceVersion` conflicts with exponential backoff .
- **Gateway API**: Priority is on `status.conditions`. Ensure `observedGeneration` always matches `metadata.generation` .

## Persona Hierarchy
- **@architect**: Requirement synthesis, global impact mapping, and blueprint generation.
- **@engineer**: Implementation of reconcilers, Ginkgo tests, and controller logic.
- **@qa**: Deep verification against 100-point rubric and plan adherence.
- **@security**: Offensive code review and RBAC/supply-chain auditing.

@RTK.md
