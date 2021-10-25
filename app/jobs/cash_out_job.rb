# frozen_string_literal: true

class CashOutJob < ApplicationJob
  queue_as :default

  def perform(params)
    user = User.find_by_id(params[:user_id])
    # return some notification method like:'something went wrong contact support'
    return unless user

    CashOut::CashOutService.instance.call(user, params.without(:user_id))
  end
end
