---
name: kubernetes-reviewer
description: Review a PR for a project that implements a Kubernetes controller
trigger: Use this when the user asks to review a code that belongs to a project implementing a Kubernetes controller
---

**Role:** You are auditing a Go Kubernetes operator for architecture, reliability, API evolution, performance, observability, and security. For each item, answer: **Pass / Fail / N/A**, cite **file paths and symbols** (or manifest paths), and note **gaps or risks** in one line.

**1. Architecture & layout**
1. Is reconciliation organized so **one primary controller maps to one CRD** (or is the split justified and documented)?
2. Does the project avoid acting as a **meta-operator** (deploying other operators)? Is install lifecycle delegated to **OLM** or equivalent where applicable?
3. Is the repo structured with clear **`api/<group>/<version>`** and **`internal/...`** for reconciliation logic not meant as a public Go API?
4. Is **manager / scheme registration** confined to **`cmd/...`** (e.g. `main`)?
5. Are **third-party API types** registered on the scheme in startup, with **fail-fast** if `AddToScheme` (or equivalent) fails?

**2. API evolution & CRDs**
6. Are API changes **additive** (no silent breaking renames/tightening that invalidates stored objects)?
7. Is API **versioning** (e.g. alpha → beta → stable) reflected in types and CRDs?
8. If multiple versions exist, is there a **hub-and-spoke** conversion story, and are **conversion webhooks** (if any) **lossless** on data and **immutable metadata**-safe?
9. Are **defaults** expressed in the **CRD/OpenAPI/schema** (`kubebuilder:default`, etc.) where possible, vs hidden only in reconciler code?
10. Where defaults depend on cluster state, is **mutating admission** (or another explicit mechanism) used; where defaults are "late," does the controller only set **unset** fields and avoid overriding user intent?

**3. Reconciliation & reliability**
11. Is `Reconcile` **idempotent** (safe to run repeatedly to the same outcome)?
12. Does status use **`metav1.Condition`** (or equivalent) with **stable ordering** and updates via **`client.Status()`** / status subresource, not accidental spec writes?
13. Are **watch predicates** used to avoid **infinite loops** from status writes (e.g. **`GenerationChangedPredicate`** where appropriate)? Are **finalizer** + generation predicates handled (requeue after add if updates are filtered)?
14. Before mutating objects from **cache reads**, is **`.DeepCopy()`** used?
15. Do writes prefer **patch / server-side apply** over blind full-object replace where appropriate? Are **list field ownership** and SSA field managers considered?
16. Do child resources use **`SetControllerReference`** / owner refs so **GC** cleans dependents?

**4. Concurrency, queue, cache**
17. Is **`MaxConcurrentReconciles`** set consciously for load?
18. Is **`Requeue` vs `RequeueAfter`** used correctly (backoff vs timed wait) for transient failures vs polling?
19. Is the **split-client eventual consistency** after create/update handled (requeue / not assuming immediate cache read)?
20. Is the **cache scope** constrained (`DefaultNamespaces`, `ByObject`, selectors) to limit memory, **without** excluding instances of **owned CRDs** from watches?
21. For queries by **non-standard fields**, is a **`FieldIndexer`** registered and used with **`MatchingFields`**?

**5. HA & lifecycle**
22. Is **leader election** enabled for multi-replica deployments with a **unique election ID**?
23. Is the election mode (**lease vs for-life**) a deliberate choice with understood failover behavior?
24. Are **network calls** made with the reconcile **`context`**, and are **timeouts** (`WithTimeout`) and **`defer cancel()`** used where needed?
25. Do long loops respect **`ctx.Done()`** / cancellation?
26. Are **liveness / readiness** (and **startup** if needed) wired to controller-runtime health checks / probes in manifests?

**7. Observability (logging & metrics)** *(renumber if you merge sections)*  
27. Is logging via **`logr`** / contextual logger with **`WithValues`/`WithName`** where it aids tracing?
28. Is verbosity / structured enrichment balanced so **hot paths** are not over-instrumented at default verbosity?
29. Are **secrets/credentials** excluded from logs?
30. Are **Prometheus metrics** named with a **clear prefix**, **base units**, correct **counter/histogram** suffixes, and **bounded label cardinality**?
31. Are custom metrics **registered** explicitly (e.g. `init` / setup) and are alerts (e.g. **PrometheusRule**) considered where relevant?

**8. Security: RBAC & workload**
32. Is RBAC **least privilege** (no unnecessary `*`, prefer namespace-scoped roles where possible)?
33. Are **high-risk verbs** (`list/watch` secrets broadly, dangerous workload create, PV abuse, `nodes/proxy`, `escalate`/`bind`/`impersonate`) justified or absent?
34. Is the operator **not** granted **`system:masters`** or equivalent bypass?
35. Does the **Pod/Deployment** align with **PSS restricted**-style hardening: **non-root**, **no privilege escalation**, **read-only root FS** where feasible, **no hostNetwork/hostPID/hostIPC**, **seccomp**?
36. For **webhooks**, is **TLS** managed sustainably (e.g. **cert-manager** + CA injection) and webhooks **replicated** for HA?

**9. Secrets**
37. If external vault integration is required, is the choice between **CSI driver vs sync-to-Secret** (e.g. ESO) explicit regarding **timing**, **etcd footprint**, and **privilege** of side components?

**10. Operations & delivery**
38. Is **GitOps** or an equivalent **declarative** promotion model used vs ad-hoc `kubectl apply` in production?
39. Are **environment differences** (resources, replicas, policies) handled via **overlays** or chart values, not copy-paste?
40. Are **multi-arch** images / manifests accounted for if the fleet is heterogeneous?
41. (Optional) For destructive testing, are **VolumeSnapshots** or similar used instead of full data copies where relevant?

**Output format:** Table or numbered list: **ID — Pass/Fail/N — evidence — risk**. End with **top 5 fixes** ordered by severity.


