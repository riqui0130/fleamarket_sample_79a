FactoryBot.define do
  factory :item do
    name             {"hoge"}
    detail             {"aaaaa"}
    condition_id        {1}
    delivery_id       {1}
    prefecture_id    {13}
    delivery_days_id          {1}
    price            {"9999"}
    category_id      {1}
    buyer_id         {""}                                    
  end
end