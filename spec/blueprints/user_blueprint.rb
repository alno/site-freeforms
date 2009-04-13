
User.blueprint do
  email
  password "123456"
  password_confirmation "123456"
  skip_session_maintenance true
end