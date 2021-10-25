# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bank::Api, type: :service do
  describe '#cash_out' do
    subject(:cash_out) { described_class.cash_out(params) }

    let!(:params) do
      {
        placeholder: "CARD PLACEHOLDER",
        card_number: "4242424242424242",
        card_expiration_date: "04/23",
        amount: "10.0"
      }
    end

    let!(:client_id) { { client_id: Bank::Api::CLIENT_ID } }

    let!(:headers) do
      {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{Bank::Api::AUTH_TOKEN}",
        'User-Agent' => 'Ruby'
      }
    end

    before do
      stub_request(:post, 'https://alfa-bank.ru/cash_out')
        .with(body: params.merge(client_id).to_json, headers: headers)
        .to_return(status: status)
    end

    context 'when api request is success' do
      let(:status) { 200 }

      it 'returns success' do
        expect(cash_out).to be_success
      end
    end

    context 'when api request is success' do
      let(:status) { 400 }

      it 'not returns success' do
        expect(cash_out).not_to be_success
      end
    end
  end
end