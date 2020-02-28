.DEFAULT_GOAL := help
ARGS=$(filter-out $@,$(MAKECMDGOALS))

.PHONY: help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: install
install: ## install
	npm install

.PHONY: check
check: ## CHECK before
	@npm run contributors check
	@git status

.PHONY: commit
commit: ## Commit data
	@npm run commit


.PHONY: git-author
git-author: ## git author
	@git log --pretty=%an\ \<%ae\>|sort|uniq -c

.PHONY: git-check
git-check: ## CHECK git
	@git gc
	@git prune
	@git fetch
