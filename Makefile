.PHONY: test
test: ## Run tests
	bundle exec rspec

.PHONY: check
check: ## Run checks and lints
	brew style colindean/fund --fix

.PHONY: deps
deps: deps-brew deps-precommit deps-ruby ## Install all dependencies

.PHONY: deps-brew
deps-brew: # Install Homebrew dependencies for development
	brew bundle install --no-lock --file=Brewfile

# TODO: setup Ruby or check against Homebrew's ruby?
.PHONY: deps-ruby
deps-ruby: ## Install Ruby Gem dependencies with Bundler
	gem install bundler && bundle install

GIT_HOOKS = .git/hooks/pre-commit
.PHONY: deps-precommit
deps-precommit: $(GIT_HOOKS) ## Install pre-commit git hooks

$(GIT_HOOKS): .pre-commit-config.yaml
	pre-commit install
