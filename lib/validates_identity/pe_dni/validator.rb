# frozen_string_literal: true

class ValidatesIdentity
  module PeDni
    class Validator
      VALIDATION_REGULAR_EXPRESSION = /^(\d{8})-?([a-zA-Z0-9]{1})$/.freeze
      VERIFIER_DIGITS = %w[6 7 8 9 0 1 1 2 3 4 5].freeze
      VERIFIER_LETTERS = %w[K A B C D E F G H I J].freeze

      attr_reader :value

      def initialize(value)
        @value = value.to_s
      end

      def valid?
        return true if value.blank?
        return false unless number

        verifier_digit == VERIFIER_LETTERS[calculated_verifier_digit_position] ||
          verifier_digit == VERIFIER_DIGITS[calculated_verifier_digit_position]
      end

      def formatted
        return if result.nil?

        "#{number}-#{verifier_digit}"
      end

      private

      def result
        @result ||= VALIDATION_REGULAR_EXPRESSION.match(value)
      end

      def number
        return if result.blank?

        @number ||= result[1]
      end

      def verifier_digit
        return if result.blank?

        @verifier_digit ||= result[2].upcase
      end

      def calculated_verifier_digit_position
        sum = multiply_and_sum([3, 2, 7, 6, 5, 4, 3, 2], number)
        result = sum % 11

        return 0 if result.zero?

        11 - result
      end

      def multiply_and_sum(array, number)
        multiplied = []
        number.scan(/\d{1}/).each_with_index { |e, i| multiplied[i] = e.to_i * array[i] }
        multiplied.inject { |s, e| s + e }
      end
    end
  end
end
