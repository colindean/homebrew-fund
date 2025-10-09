#!/usr/bin/env ruby
# typed: false
# frozen_string_literal: true
module Homebrew
  module Cmd
    class Fund < AbstractCommand
      cmd_args do
        description <<~EOS
          Show funding information for a Homebrew package or set of packages
        EOS

        switch "-v", "--verbose",
             description: "Show what's being done"
        named_args [:formula, :cask], min: 1
      end

      def run
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
    
            fmresolver = FundingMethodsResolver.new(package)
    
            puts fmresolver.suggest_all
    
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
  end
end
