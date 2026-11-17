# Requirements and acceptance plan

## Functional

- Authenticated document upload initiation returns a short-lived S3 URL.
- Metadata persisted with ownership and states: PENDING_UPLOAD, QUEUED, PROCESSING, COMPLETED, FAILED.
- S3 event drives asynchronous processing via SQS and Lambda.
- Authenticated status lookup reads only caller-owned documents.
- Repeat events do not create duplicate externally observable effects.

## Nonfunctional proposed targets (not measured)

- Two availability zones and minimum 2 healthy API instances during normal operation.
- API availability SLO: 99.9% measured over rolling 30 days.
- Status read p95 latency <300ms at documented test load.
- 5xx response rate <1% under documented test conditions.
- 95% of supported small documents finish processing within 60s at documented test load.

## Evidence required

Record Terraform plan/apply outputs (redacted), AWS configuration screenshots, healthy target screenshots, load-testing reports, failed-instance replacement timings, idempotency tests, DLQ alarm tests, CloudWatch dashboards and recovery exercises.

## Phase 1 acceptance

- Architecture and event flow documented.
- Trade-offs and initial cost strategy documented.
- Threat model and proposed SLOs documented.
- Local repo committed; remote GitHub repo optional until user confirms.
- No AWS infrastructure required at this phase.
