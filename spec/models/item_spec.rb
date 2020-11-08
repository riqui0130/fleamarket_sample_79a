require 'rails_helper'
describe Item do
  describe '#create' do

    it "image, name, detail, price, condition_id, deliverydays_id, delivery_id, prefecture_id, category_id, seller_idがあれば出品できること" do
      user = create(:user)
      item = build(:item, seller_id: user[:id])
      expect(item).to be_valid
    end

    it 'brandがなくても出品できること' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], brand: nil)
      expect(item).to be_valid
    end

    it "imageが0枚だと出品できないこと" do
      user = create(:user)
      item = Item.new(name: "abc", detail: "abc", price: 1000, condition_id: 1, delivery_id: 1, deliverydays_id: 1, prefecture_id: 1, category_id: 1, seller_id: user[:id])
      item.valid?
    end

    it 'nameがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], name: nil)
      item.valid?
    end

    it 'nameが40字以上だと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], name: "123456789123456789123456789123456789123456789")
      item.valid?
    end

    it 'detailがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], text: nil)
      item.valid?
    end

    it 'priceがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], price: nil)
      item.valid?
    end

    it 'condition_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], status_id: nil)
      item.valid?
    end

    it 'delivery_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], postage_id: nil)
      item.valid?
    end

    it 'deliverydays_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], days_id: nil)
      item.valid?
    end

    it 'prefecture_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], prefecture_id: nil)
      item.valid?
    end

    it 'category_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], category_id: nil)
      item.valid?
    end

  end
end