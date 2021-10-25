# frozen_string_literal: true

module CashOut
  class CashOutContract < Dry::Validation::Contract
    BankSchema = Dry::Schema.Params do
      required(:placeholder).filled(:string)
      required(:card_number).filled(:string)
      required(:card_expiration_date).filled(:string)
      required(:amount).filled(:string)
    end

    params do
      required(:bank_attributes).hash(BankSchema)
    end
  end
end
