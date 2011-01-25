
Form.blueprint do
  user
  title { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph }
  submit_title { Faker::Lorem.sentence }
end
