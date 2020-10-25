FactoryBot.define do
  factory :item do
    name             {"hoge"}
    text             {"aaaaa"}
    status_id        {1}
    postage_id       {1}
    prefecture_id    {13}
    days_id          {1}
    price            {"9999"}
    category_id      {1}
    buyer_id         {""}
    after(:build) do |item|
      item.images << build(:image, item: item)  
    end                                       
  end
end