# frozen_string_literal: true

module Fund
  module Presenters
    # Base class for all presenters
    class PresenterBase
      sig { returns(T.untyped) }
      attr_reader :data

      sig { params(data: T.untyped).void }
      def initialize(data)
        @data = data
      end

      # Returns a string representation suitable for display
      # @return [String]
      sig { returns(String) }
      def to_s
        raise NotImplementedError, "#{self.class.name} must implement #to_s"
      end

      # Returns a hash representation of the presenter data
      # @return [Hash{Symbol => String}]
      sig { returns(T::Hash[Symbol, String]) }
      def to_h
        raise NotImplementedError, "#{self.class.name} must implement #to_h"
      end

      # Returns whether the presenter has any data to display
      # @return [Boolean]
      sig { returns(T::Boolean) }
      def empty?
        data.blank?
      end

      # Returns whether the presenter has data to display
      # @return [Boolean]
      sig { returns(T::Boolean) }
      def present?
        !empty?
      end
    end
  end
end
