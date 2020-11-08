require 'rails_helper'
describe Item do
  describe '#create' do

    it "image, name, detail, price, condition_id, delivery_days_id, delivery_id, prefecture_id, category_id, seller_idがあれば出品できること" do
      item = build(:item)
      expect(item).to be_valid
    end

    it 'is valid without brand' do
      item = build(:item, brand: nil)
      expect(item).to be_valid
    end

    it "is invalid without image" do
      item = build(:item, image: nil)
      itme.valid?
      expect(item.errors[:image]).to include("can't be blank")
    end

    it "is invalid without name" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "is invalid without detail" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:detail]).to include("can't be blank")
    end

    it "is invalid without price" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "is invalid without condition_id" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:condition_id]).to include("can't be blank")
    end

    it "is invalid without delivery_id" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:delivery_id]).to include("can't be blank")
    end

    it "is invalid without delivery_days_id" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:delivery_days_id]).to include("can't be blank")
    end

    it "is invalid without prefecture_id" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end

    it "is invalid without category_id" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

  end
end