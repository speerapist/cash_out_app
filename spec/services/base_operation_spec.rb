# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe ::BaseOperation, type: :service do
  specify '.instance always refers to the same instance' do
    expect(BaseOperation.instance).to be_a_kind_of(BaseOperation)
    expect(BaseOperation.instance).to equal(BaseOperation.instance)
  end
end
