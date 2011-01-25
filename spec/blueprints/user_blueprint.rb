
User.blueprint do
  email { Faker::Internet.email }
  password { "123456" }
  password_confirmation { "123456" }
  skip_session_maintenance { true }
end
