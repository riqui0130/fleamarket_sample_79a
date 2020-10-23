require 'rails_helper'
describe Item do

  describe '#create' do
    it "is valid with a name, text, price, status_id, days_id, postage_id, prefecture_id, category_id" do
      item = FactoryBot.build(:item)
      expect(item).to be_valid
    end
  end
end