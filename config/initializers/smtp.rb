ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'gmail.com',
  user_name: ENV['wastedfood1@gmail.com'],
  password: ENV['ecpoqqlmveymnnbd'],
  authentication: :login,
  enable_starttls_auto: true
}
