# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.decimal :amount, default: 0
    end
  end
end
