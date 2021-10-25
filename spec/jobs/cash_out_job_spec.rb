# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CashOutJob, type: :job do
  describe '#perform_later' do
    subject(:perform) { described_class.new.perform(params) }
    let!(:user) { create(:user) }

    let(:params) do
      {
        user_id: user_id,
        bank_attributes:
          {
            placeholder: 'CARD PLACEHOLDER',
            card_number: '4242424242424242',
            card_expiration_date: '04/23',
            amount: '10.0'
          }
      }
    end

    let!(:user_id) { '2' }

    it 'creates queue' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        CashOutJob.perform_later(params)
      end.to have_enqueued_job
    end

    before do
      allow_any_instance_of(CashOut::CashOutService).to receive(:call)
    end

    context 'when user present' do
      let!(:user_id) { '1' }
      
      it 'calls CashOutService' do
        expect_any_instance_of(
          CashOut::CashOutService)
        .to receive(:call).with(user, params.without(:user_id)).once

        perform
      end
    end

    context 'when user not present' do
      let(:user_id) { '3' }

      it 'does not call CashOutService' do
        expect_any_instance_of(
          CashOut::CashOutService)
        .not_to receive(:call)

        perform
      end
    end
  end
end
