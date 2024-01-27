# homebrew-fund [![CI](https://github.com/colindean/homebrew-fund/actions/workflows/tests.yml/badge.svg)](https://github.com/colindean/homebrew-fund/actions/workflows/tests.yml)

:construction:
This is a **WORK IN PROGRESS.**
It may not work.
It may be wrong.
_Don't trust it until 1.0.0._

Homebrew-fund provides a command `brew fund` helps you fund the upstream development of your favorite Homebrew packages by suggesting where the package collections donations or other financial support.

`brew fund` came out of [Homebrew/brew#15890](https://github.com/Homebrew/brew/issues/15890).

## Installation

TBD

## Usage

Run `brew fund` for online help, but normal usage is to pass a package in particular, e.g.

    brew fund curl

will show potential places to fund the development of [curl](https://formulae.brew.sh/formula/curl).

## Caveats

Homebrew-fund uses a series of heuristics to _suggest_ possible donation methods for a package.
Donation methods may change.
The heuristic could be wrong.

**You are solely responsible for validating that payments made through any facility go to the intended recipient.**

## Heuristics

:warning: Check the code as this list may be out of date.

In general, Homebrew-fund will always attempt to retrieve the least amount of data in order to make a reasonable guess at the right URL(s) to provide.

1. :waning_gibbous_moon: If the project has a GitHub homepage or download link,
   use the GitHub GraphQL API to retrieve the project's funding links, configured in `FUNDING.yaml` in a few known places.
2. :new_moon: Download the source archive and…
    1. look for files such as `FUNDING.yaml`, `DONATIONS.md`, etc.
    2. look for a Donations section in a README

Completion indicated by moon phases:
|Icon|Meaning|
|----|-------|
|:new_moon:|Not started|
|:waning_crescent_moon:|Started|
|:waning_gibbous_moon:|Almost there, not thoroughly tested|
|:full_moon:|Working as brightly as the moon in the night sky|

## Tests

Tests can be run with `bundle install && bundle exec rspec`.

## Contributing

This repository defines a [DevContainers](https://containers.dev/) configuration that loads well in GitHub Codespaces and VSCode/VSCodium.

Add tests to keep coverage above 70%.
Once the app is 1.0, we'll ratchet coverage up toward 100%.

## Copyright

Copyright (c) Colin Dean. See [LICENSE](LICENSE) for details.
