FactoryBot.define do
  factory :item do
    name             {"hoge"}
    text             {"aaaaa"}
    status_id     {1}
    postage_id  {1}
    prefecture_id          {13}
    days_id {1}
    price            {"9999"}
    category_id       {1}
  end
    # 1枚の画像をアップロードする
    trait :image do
      after(:build) do |item|
        File.open("#{Rails.root}/spec/images/Unknown.jpeg") do |f|
          item.images.attach(io: f, filename: "Unknown.jpeg", content_type: 'image/jpeg')
        end
      end
    end
    # 11枚の画像をアップロードする
    trait :images do
      after(:build) do |item|
        11.times do
          File.open("#{Rails.root}/spec/images/Unknown.jpeg") do |f|
            item.images.attach(io: f, filename: "Unknown.jpeg", content_type: 'image/jpeg')
          end
        end
      end
    end
end