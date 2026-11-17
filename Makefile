.PHONY: help check-docs
help:
	@echo 'Phase 1 commands:'
	@echo '  make check-docs - verify required architecture documents exist'
check-docs:
	@test -s README.md
	@test -s docs/architecture/overview.md
	@test -s docs/adr/0001-architecture-decisions.md
	@test -s docs/security/threat-model.md
	@test -s docs/requirements/requirements.md
	@test -s docs/cost/cost-strategy.md
	@echo 'Phase 1 documentation checks passed.'
