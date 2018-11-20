class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = [ 'seb@lewagon.org' ]
  end
end
