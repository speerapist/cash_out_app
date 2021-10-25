# frozen_string_literal: true

module Api
  module V1
    class CashOutController < ApplicationController
      def update
        CashOutJob.perform_later(cash_out_params.to_h)

        render status: :ok
      end

      private

      def cash_out_params
        params.require(:cash_out)
          .permit(:user_id, bank_attributes: %i[placeholder card_number card_expiration_date amount])
      end
    end
  end
end
