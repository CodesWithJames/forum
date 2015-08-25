FactoryGirl.define do
  factory :topic do
    subject { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph(2) }
    user_id { User.build(FactoryGirl.attributes_for(:user)).id }
  end
end
