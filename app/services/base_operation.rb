# frozen_string_literal: true

class BaseOperation
  extend Dry::Initializer

  class << self
    def instance
      @instance ||= new
    end
  end
end
