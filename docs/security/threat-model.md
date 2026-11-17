# Initial threat model

**Status:** Proposed controls, not verified.

## Assets

Customer documents, document ownership and metadata, API identity, AWS permissions, CI/CD permissions, encryption keys, Terraform state.

## Trust boundaries

Public client -> HTTPS ALB -> private EC2 API; client -> presigned S3 upload; S3 event -> SQS -> Lambda; application identities -> DynamoDB.

## Risks and proposed controls

| Threat | Control | Validation later |
| --- | --- | --- |
| Unauthorized document access | authenticated requests, per-owner authorization, least-privilege IAM | negative API tests |
| Public S3 objects | block public access, scoped bucket policy, encryption | AWS config/policy inspection |
| Upload abuse | file size limits, allowed types, per-user quotas, short-lived URLs | invalid upload tests |
| Malicious content | content validation, optional malware scanning before delivery | malicious test fixture |
| Duplicate/out-of-order events | per-document conditional updates, idempotency key | repeat and reordering tests |
| Denial of service | rate limiting, bounded processing concurrency, SQS buffering | k6 and throttling tests |
| Credential exposure | GitHub OIDC, secrets manager, no local secrets in git | secret scanning |
| Failed processing | retry policy, DLQ, alarm, operator replay runbook | forced failure tests |

## Constraints

Never log document contents or secrets. Document retention and privacy requirements before accepting real user data. Do not claim SOC 2, HIPAA, or other regulatory compliance.
