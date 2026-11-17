# ADR-0001 — Initial platform architecture

**Status:** Proposed  
**Date:** 2026-11-17

## Context

We need a realistic multi-AZ AWS application demonstrating horizontal scaling, serverless event processing, durable metadata and operational resilience without an unnecessary always-on cost burden.

## Decision

- EC2 Auto Scaling behind an HTTPS Application Load Balancer for the stateless API tier.
- Presigned S3 uploads instead of proxying file bodies through EC2.
- S3 events -> SQS standard queue -> Lambda processor; DLQ for messages that exhaust retries.
- DynamoDB on-demand for document status metadata.
- Terraform with modules and remote state for reproducible environments.
- GitHub Actions OIDC for temporary AWS permissions.

## Consequences and trade-offs

- EC2 and ALB cost more operational effort than API Gateway + Lambda, but demonstrate the requested fleet operations.
- SQS improves buffering and failure management but requires idempotent processors and visibility-timeout configuration.
- DynamoDB is efficient for known key-based access patterns, but designing indexes and conditional writes matters.
- Two AZs reduce common instance/AZ risks but do not provide multi-region recovery.
- NAT gateways can be major development costs. Local-first work and ephemeral cloud environments are preferred.
