FactoryBot.define do

  factory :images do
    image       {File.open("#{Rails.root}/spec/fixtures/test.png")}
    association :item
  end

end