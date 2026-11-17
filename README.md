# CloudResilience

Production-minded AWS event-driven document processing platform, built incrementally with evidence-driven engineering.

## Status

**Phase 1 — Architecture and repository foundation.** No AWS resources have been provisioned and no application functionality is claimed as implemented.

## Business problem

Provide secure document upload initiation and processing status APIs, direct-to-S3 uploads, asynchronous validation and metadata processing, and reliable status tracking.

## Proposed architecture

Clients -> HTTPS ALB -> stateless TypeScript API on EC2 Auto Scaling (two AZs) -> DynamoDB + S3 presigned upload. S3 ObjectCreated -> SQS standard queue -> TypeScript Lambda processor -> DynamoDB. SQS DLQ retains failed messages. CloudWatch monitors the components.

See [architecture](docs/architecture/overview.md), [requirements](docs/requirements/requirements.md), [threat model](docs/security/threat-model.md), [ADR](docs/adr/0001-architecture-decisions.md), and [cost decisions](docs/cost/cost-strategy.md).

## Initial engineering decisions

- AWS `eu-west-1` as a proposed region, subject to account availability and cost assessment.
- TypeScript/Node.js API and Lambda worker.
- Terraform modules, separate environments, remote state and locking, implemented in later phases.
- SQS standard delivery is at least once; idempotency and event ordering must be handled explicitly.
- No hardcoded secrets; use OIDC federation for GitHub Actions deployment.

## Project phases

1. Project foundation and design (current)
2. AWS IAM, tools, Terraform and GitHub OIDC
3. VPC and two-AZ networking
4. EC2 ASG and ALB
5. API and containerization
6. S3 presigned uploads
7. Lambda and DynamoDB
8. SQS retries, DLQ and idempotency
9. Terraform modules and environments
10. GitHub Actions pipelines
11. Security hardening
12. CloudWatch monitoring and SLOs
13. Load and resilience testing
14. Disaster recovery and runbooks
15. Cost review and final evidence

## Safety and cost

Do not create chargeable infrastructure without reviewing costs. Lab resources should be destroyed when not needed. Do not put credentials, Terraform state, or real user documents into git.

## Verify Phase 1

```bash
git status --short
find docs -type f | sort
```

## License

No license has been selected yet. Choose one deliberately before publishing reusable code.
