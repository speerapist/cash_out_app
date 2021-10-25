# frozen_string_literal: true

require 'dry/validation'
require 'dry/initializer'

module CashOut
  class Error < StandardError
    extend Dry::Initializer
  end

  class ValidationError < Error
    param :errors

    def message
      "Validation failed: #{full_messages}"
    end

    def full_messages
      errors.each_pair.map { |k, v| "#{k.to_s.humanize} #{Array.wrap(v).join(', ')}" }.join('; ')
    end

    def to_s
      errors.to_s
    end
  end
end

module Dry
  module Validation
    class Result
      def to_cash_out_validation_result!
        if success?
          to_h
        else
          raise CashOut::ValidationError, errors.to_h
        end
      end
    end
  end
end
