# frozen_string_literal: true

module Utils
  module Output
    module Mixin
      def opoo(*); end

      def odie(*)
        exit 1
      end

      def odebug(*); end
    end
  end
end
