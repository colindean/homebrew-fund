# tools
PRECOMMIT ?= pre-commit

.PHONY: test
test: ## Run tests
	bundle exec rspec

.PHONY: check
check: ## Run checks and lints
	brew style --fix colindean/fund

.PHONY: deps
deps: deps-brew deps-precommit deps-ruby ## Install all dependencies

.PHONY: deps-brew
deps-brew: # Install Homebrew dependencies for development
	brew bundle install --verbose --file=Brewfile

# TODO: setup Ruby or check against Homebrew's ruby?
.PHONY: deps-ruby
deps-ruby: ## Install Ruby Gem dependencies with Bundler
	(command -v bundle || gem install bundler) && bundle install

GIT_HOOKS = .git/hooks/pre-commit
.PHONY: deps-precommit
deps-precommit: $(GIT_HOOKS) ## Install pre-commit git hooks

$(GIT_HOOKS): .pre-commit-config.yaml
	$(PRECOMMIT) install

BFDV = brew fund --debug --verbose

.PHONY: test-smoke
test-smoke: ## Run a basic smoke test against a well
	$(BFDV) curl
	$(BFDV) brew
	$(BFDV) homebrew-fund
	$(BFDV) sqlite

.PHONY: pc
pc: check test test-smoke ## Run tasks run before committing including pre-commit
	$(PRECOMMIT) run
