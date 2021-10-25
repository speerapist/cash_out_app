# frozen_string_literal: true

module CashOut
  class CashOutService < BaseOperation
    def call(user, params)
      params = validate_params(params)
      amount = params[:amount].to_f
      # return some notification method like:'something went wrong contact support'
      return unless user.cash_out_amount_valid?(amount)

      response = send_request(params)

      if response.success?
        user.update(amount: user.amount - amount)
      else
        #return some notification method like:'something went wrong contact support'
      end

    rescue CashOut::ValidationError => e
      # send some notification method like:'something went wrong contact support'
    end

    private

    def validate_params(params)
      CashOut::CashOutContract.new.call(params).to_cash_out_validation_result![:bank_attributes]
    end

    def send_request(params)
      Bank::Api.cash_out(params)
    end
  end
end
