require 'rails_helper'

RSpec.describe Creditcard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe User do
  describe '#create user_idなしに、クレジットカード登録できないこと' do
    it "is invalid without a user_id" do
    creditcard = Creditcard.new(user_id: "", card_id: "car_2336933bf5edf799eb6f532f9785",customer_id: "cus_703ca7bc09cc7ba56e0f4ccbb9b2" )
    creditcard.valid?
    expect(creditcard.errors[:user_id]).to include("can't be blank")
    end
  end
end

describe User do
  describe '#create card_idなしに、クレジットカード登録できないこと' do
    it "is invalid without a card_id" do
    creditcard = Creditcard.new(user_id: "2", card_id: "",customer_id: "cus_703ca7bc09cc7ba56e0f4ccbb9b2" )
    creditcard.valid?
    expect(creditcard.errors[:card_id]).to include("can't be blank")
    end
  end
end

describe User do
  describe '#create customer_idなしに、クレジットカード登録できないこと' do
    it "is invalid without a customer_id" do
    creditcard = Creditcard.new(user_id: "2", card_id: "car_2336933bf5edf799eb6f532f9785",customer_id: "" )
    creditcard.valid?
    expect(creditcard.errors[:customer_id]).to include("can't be blank")
    end
  end
end