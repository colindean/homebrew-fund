# homebrew-fund

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

    brew fund brew

will show potential places to fund the development of Homebrew itself.

## Caveats

Homebrew-fund uses a series of heuristics to _suggest_ possible donation methods for a package.
Donation methods may change.
The heuristic could be wrong.

**You are solely responsible for validating that payments made through any facility go to the intended recipient.**

## Heuristics

:warning: Check the code as this list may be out of date.

In general, Homebrew-fund will always attempt to retrieve the least amount of data in order to make a reasonable guess at the right URL(s) to provide.

1. If the project has a GitHub homepage or download link,
   look at the project for a `FUNDING.yaml` in a few known places.
2. Download the source archive and…
    1. look for files such as `FUNDING.yaml`, `DONATIONS.md`, etc.
    2. look for a Donations section in a README


## Tests

Tests can be run with `bundle install && bundle exec rspec`.

## Copyright

Copyright (c) Colin Dean. See [LICENSE](LICENSE) for details.
