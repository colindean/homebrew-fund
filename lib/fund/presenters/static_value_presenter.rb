# frozen_string_literal: true

module Fund
  module Presenters
    # Presenter for static string values
    class StaticValuePresenter < PresenterBase
      def initialize(data)
        super
        @data = data
      end

      def to_s
        @data.to_s
      end

      def to_h
        {
          source: "homebrew-fund database",
          value:  @data,
        }
      end
    end
  end
end
