# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CashOutController, type: :request do
  describe 'POST/cash_out' do
    subject(:cash_out) { post('/v1/cash_out', params: params) }

    let!(:params) do
      {
        cash_out:
          {
            user_id: '1',
            bank_attributes:
              {
                placeholder: 'CARD PLACEHOLDER',
                card_number: '4242424242424242',
                card_expiration_date: '04/23',
                amount: '10.0'
              }
          }
      }
    end

    before do
      allow(CashOutJob).to receive(:perform_later)
    end

    it 'calls CashOutJob worker' do
      cash_out

      expect(CashOutJob).to have_received(:perform_later).with(params[:cash_out]).once
    end
  end
end
