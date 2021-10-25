require 'spec_helper'
require 'rails_helper'

RSpec.describe CashOut::CashOutService, type: :service do
	describe '#call' do
		subject(:call) { described_class.instance.call(user, params)}

		let!(:user) { create(:user) }
		let(:client_id) { { client_id: Bank::Api::CLIENT_ID } }

		context 'when params valid and cash_out_amoutn less then user amount' do
			let!(:params) do
				{
					bank_attributes:
					{
						placeholder: "CARD PLACEHOLDER",
				  	card_number: "4242424242424242",
					  card_expiration_date: "04/23",
			 	    amount: "10.0"
					}
				}
			end

			let!(:headers) do
      	{
        	'Accept' => '*/*',
        	'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        	'Content-Type' => 'application/json',
        	'Authorization' => "Bearer #{Bank::Api::AUTH_TOKEN}",
        	'User-Agent' => 'Ruby'
      	}
    	end

			let!(:status) { 200 }

			before do
      	stub_request(:post, 'https://alfa-bank.ru/cash_out')
        	.with(body: params[:bank_attributes].merge(client_id).to_json, headers: headers)
        	.to_return(status: status)
    	end

			it 'updates user amount' do
				amount = user.amount - params[:bank_attributes][:amount].to_f
				call

				expect(user.amount).to eq(amount)
			end
		end

		context 'when params invalid' do
			let!(:params) do
				{
					bank_attributes:
					{
						placeholder: "CARD PLACEHOLDER",
					  card_expiration_date: "04/23",
			 	    amount: "10.0"
					}
				}
			end

			it 'updates user amount' do
				amount = user.amount - params[:bank_attributes][:amount].to_f
				call

				expect(user.amount).not_to eq(amount)
			end
		end

		context 'when params invalid' do
			let!(:params) do
				{
					bank_attributes:
					{
						placeholder: "CARD PLACEHOLDER",
				  	card_number: "4242424242424242",
					  card_expiration_date: "04/23",
			 	    amount: "100.1"
					}
				}
			end

			it 'updates user amount' do
				amount = user.amount - params[:bank_attributes][:amount].to_f
				call

				expect(user.amount).not_to eq(amount)
			end
		end
	end
end