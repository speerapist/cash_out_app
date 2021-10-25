# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe CashOut::CashOutContract, type: :service do
  subject(:contract) { described_class.new }

  describe '#call' do
    subject(:call) { contract.call(params) }

    let(:params) do
      {
        bank_attributes:
          {
            placeholder: 'CARD PLACEHOLDER',
            card_number: '4242424242424242',
            card_expiration_date: '04/23',
            amount: '10.0'
          }
      }
    end

    context 'when validations passed' do
      describe 'result' do
        it { is_expected.to be_success }
      end
    end

    context 'with non exists `bank_attributes` param' do
      before { params.delete(:bank_attributes) }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: ['is missing'] }) }
      end
    end

    context 'with wrong format of `bank_attributes` param' do
      before { params[:bank_attributes] = 'some text stuff' }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: ['must be a hash'] }) }
      end
    end

    context 'with non exists `bank_attributes[:placeholder]` param' do
      before { params[:bank_attributes].delete(:placeholder) }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: { placeholder: ['is missing'] } }) }
      end
    end

    context 'with wrong format of `bank_attributes [:placeholder]` param' do
      before { params[:bank_attributes][:placeholder] = 10 }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: { placeholder: ['must be a string'] } }) }
      end
    end

    context 'with non exists `bank_attributes[:card_number]` param' do
      before { params[:bank_attributes].delete(:card_number) }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: { card_number: ['is missing'] } }) }
      end
    end

    context 'with wrong format of `bank_attributes [:card_number]` param' do
      before { params[:bank_attributes][:card_number] = 10 }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: { card_number: ['must be a string'] } }) }
      end
    end

    context 'with non exists `bank_attributes[:card_expiration_date]` param' do
      before { params[:bank_attributes].delete(:card_expiration_date) }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: { card_expiration_date: ['is missing'] } }) }
      end
    end

    context 'with wrong format of `bank_attributes [:card_expiration_date]` param' do
      before { params[:bank_attributes][:card_expiration_date] = 10 }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: { card_expiration_date: ['must be a string'] } }) }
      end
    end

    context 'with non exists `bank_attributes[:amount]` param' do
      before { params[:bank_attributes].delete(:amount) }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: { amount: ['is missing'] } }) }
      end
    end

    context 'with wrong format of `bank_attributes [:amount]` param' do
      before { params[:bank_attributes][:amount] = 10 }

      describe 'result' do
        it { is_expected.to be_failure }
      end

      describe 'errors' do
        it { expect(call.errors.to_h).to eq({ bank_attributes: { amount: ['must be a string'] } }) }
      end
    end
  end
end
