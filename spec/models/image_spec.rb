FactoryBot.define do

  factory :images do
    images       {File.open("#{Rails.root}/spec/fixtures/test.png")}
    association :items
  end

end
