FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph(2) }
    user_id { User.build(FactoryGirl.attributes_for(:user)).id }
    topic_id { Topic.build(FactoryGirl.attributes_for(:topic)).id }
  end
end
