#!/usr/bin/env ruby
# frozen_string_literal: true

require "cli/parser"
module Homebrew
  module_function

  def fund_args
    Homebrew::CLI::Parser.new do
      usage_banner <<~EOS
        `fund` [<subcommand>]

        Show funding information for a Homebrew package or set of packages

        `brew fund` [`package`]:
        Show funding information for a Homebrew package
      EOS
      switch "-v", "--verbose",
             description: "Show what's being done"

      named_args [:formula, :cask]
    end
  end

  def fund
    args = fund_args.parse

    # Keep this after the .parse to keep --help fast.
    require_relative "../lib/fund"

    begin
      case subcommand = args.named.first.presence
      when nil, "fund"
        ohai "Usage: brew fund [package]"
        # TODO: How to show usage defined in the parser?
      else
        # TODO: better way to get it from the parser
        package = subcommand

        puts FundingMethodsResolver.suggest(package)

        # raise UsageError, "unknown subcommand: #{subcommand}"
      end
    rescue SystemExit => e
      Homebrew.failed = true unless e.success?
      puts "Kernel.exit" if args.debug?
    rescue Interrupt
      puts # seemingly a newline is typical
      Homebrew.failed = true
    rescue RuntimeError, SystemCallError => e
      raise if e.message.empty?
      onoe e
      puts e.backtrace if args.debug?
      Homebrew.failed = true
    rescue => e
      onoe e
      puts "#{Tty.bold}Please report this bug:#{Tty.reset}"
      puts "  #{Formatter.url("https://github.com/colindean/homebrew-fund/issues")}"
      puts e.backtrace
      Homebrew.failed = true
    end
  end
end
