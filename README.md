# homebrew-fund

[![CI](https://github.com/colindean/homebrew-fund/actions/workflows/tests.yml/badge.svg)](https://github.com/colindean/homebrew-fund/actions/workflows/tests.yml)
![Codecov](https://img.shields.io/codecov/c/github/colindean/homebrew-fund)
![GitHub License](https://img.shields.io/github/license/colindean/homebrew-fund)
![GitHub repo size](https://img.shields.io/github/repo-size/colindean/homebrew-fund)
![GitHub Repo stars](https://img.shields.io/github/stars/colindean/homebrew-fund?style=flat)

> [!WARNING]
:construction:
This is a **WORK IN PROGRESS.**
It may not work.
It may break your `brew`.
It may provide incorrect funding links.
_Don't trust it until 1.0.0._
>
> ![GitHub Release](https://img.shields.io/github/v/release/colindean/homebrew-fund)

Homebrew-fund provides a [Homebrew](https://brew.sh) command `brew fund` that
helps you fund the upstream development of your favorite Homebrew packages by
suggesting where the package collects donations or other financial support.

`brew fund` came out of [Homebrew/brew#15890](https://github.com/Homebrew/brew/issues/15890).

## Installation

Simply tap this repository:

    brew tap colindean/fund

## Usage

Run `brew fund` for online help, but normal usage is to pass a package in particular, e.g.

    brew fund curl

will show potential places to fund the development of [curl](https://formulae.brew.sh/formula/curl).

## Caveats

Homebrew-fund uses a series of heuristics to _suggest_ possible donation methods for a package.
Donation methods may change.
The heuristic could be wrong.

> [!IMPORTANT]
> **You are solely responsible for validating that payments made through any facility go to the intended recipient.**

## Heuristics

> [!WARNING]
> Until 1.0.0, check the code, as this list may be outdated.

In general, Homebrew-fund will always attempt to retrieve the least amount of data in order to make a reasonable guess at the right URL(s) to provide.

1. :last_quarter_moon: A hardcoded URL for projects that aren't Homebrew packages specifically, such as Homebrew itself.
1. :last_quarter_moon: If the project has a GitHub homepage or download link,
   use the GitHub GraphQL API to retrieve the project's funding links,
   configured in [`FUNDING.yaml` in a few known places][fundingyml].
   You may need to set a `GITHUB_TOKEN` or `HOMEBREW_GITHUB_API_TOKEN` environment variable to use this API.
1. :new_moon: Download the source archive and…
    1. :new_moon: Look for files such as [`FUNDING.yml`][fundingyml], `DONAT{E|IONS}{.md,.adoc,.txt}`, etc.
    1. :new_moon: Look for a Donations section in a `README{.md,.adoc,.txt}`
1. :new_moon: Scrape the homepage for links to
    1. :new_moon: A `/donate` or `/donations` link
    1. :new_moon: Well-known donations pages, such as those documented in the [`FUNDING.yml`][fundingyml] spec.

[fundingyml]: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/displaying-a-sponsor-button-in-your-repository

Completion indicated by moon phases:
|Icon|Meaning|
|----|-------|
|:new_moon:|Not started|
|:waning_crescent_moon:|Started|
|:last_quarter_moon:|Almost there, not thoroughly tested|
|:full_moon:|Working as brightly as the moon in the clear night sky… which means it sometimes might not|
|:full_moon_with_face:|Feature complete and should always be working|

## Contributing

Contributions are welcome.
Please consider opening an issue to describe what you'd like to do before doing it.
I prize code submissions, but I really have to understand them to accept them.

### Getting started

This repository defines a [DevContainers](https://containers.dev/) configuration that loads well in GitHub Codespaces and VSCode/VSCodium.

Run `make deps check test` with Homebrew's Ruby pre-installed, and it should be ready to go.
If you use the DevContainer, it already is.

### Tests

Tests can be run with `make test`.

Add tests to keep coverage above 70%.
Once the app is 1.0, we'll ratchet coverage up toward 100%.

## Copyright

Copyright (c) 2023 Colin Dean. See [LICENSE](LICENSE) for details.
