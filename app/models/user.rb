# frozen_string_literal: true

class User < ApplicationRecord
  def cash_out_amount_valid?(cash_out_amount)
    amount >= cash_out_amount
  end
end
