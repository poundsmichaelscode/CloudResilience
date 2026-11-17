# Cost strategy — Phase 1

**No cost estimate is a billing guarantee.** Calculate actual service costs for chosen region and expected hours using https://calculator.aws/ before any Terraform apply.

## Modes

1. Local-only: lint, typecheck, tests, Terraform validation; no continuously billed cloud fleet.
2. Ephemeral lab: EC2/ALB/NAT or endpoints deployed for short testing windows, destroyed after evidence collection.
3. Production reference: per-AZ egress, ALB HTTPS, autoscaling, managed storage, alarms, backup, DR.

## Major cost drivers

- NAT gateway hourly charges and per-GB processing, plus cross-AZ transfer when applicable.
- ALB hourly + capacity unit charges.
- EC2, attached EBS, public IPv4, outbound traffic.
- DynamoDB read/write/storage and backup.
- S3 object storage/requests, CloudWatch logs, SQS requests, Lambda duration.

## Decisions

Do not provision NAT gateways simply to validate Terraform syntax. Consider VPC endpoints when they replace large NAT traffic economically. Do not rely on a single NAT gateway for production AZ fault tolerance. Document any cost-optimized development compromise.

## Cleanup

Run `terraform plan -destroy`, check the affected account/region/environment, and then `terraform destroy` only after confirming data retention. Check residual EBS snapshots, log groups, S3 buckets, elastic IPs, and DynamoDB backups.
