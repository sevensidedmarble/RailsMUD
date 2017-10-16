require 'rails_helper'

describe Actor, type: :model do
  it 'has a valid factory' do
    expect(actor).to be_valid
  end
end