# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
	describe '#cash_out_amount_valid?' do
		subject(:call) { user.cash_out_amount_valid?(cash_out_amount) }

		let!(:user) { create(:user) }

		context 'when cash_out_amount valid' do
		  let!(:cash_out_amount) { 50 }

		  it 'returns true' do
		  	expect(subject).to be_truthy
		  end 
		end

		context 'when cash_out_amount not valid' do
		  let!(:cash_out_amount) { 100.01 }

		  it 'returns true' do
		  	expect(subject).to be_falsey
		  end 
		end
	end
end