# frozen_string_literal: true

require "cli/parser"
module Homebrew
  module_function

  def bundle_args
    Homebrew::CLI::Parser.new do
      usage_banner <<~EOS
        `fund` [<subcommand>]

        Show funding information for a Homebrew package or set of packages

        `brew fund` [`package`]:
        Show funding information for a Homebrew package
      EOS
      switch "-v", "--verbose",
             description: "Show what's being done"
    end
  end

  def bundle
    args = bundle_args.parse

    # Keep this after the .parse to keep --help fast.
    # require_relative "../lib/fund"

    begin
      case subcommand = args.named.first.presence
      when nil, "fund"
        odie "Unimplemented"
      else
        raise UsageError, "unknown subcommand: #{subcommand}"
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
