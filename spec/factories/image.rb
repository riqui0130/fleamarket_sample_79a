FactoryBot.define do

  factory :image do
    image       {File.open("#{Rails.root}/spec/fixtures/test.png")}
    association :item
  end

end