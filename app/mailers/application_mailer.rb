class ApplicationMailer < ActionMailer::Base
  default from: "genomma@live.com"
  #layout 'mailer'
	  def send_mail(email)
	  	email_technical_secretary = "#{APP_CONFIG[:production][:e_mail_technical_secretary]}"
		#@user = user
		#@url  = 'http://codeHero.co'
		mail(to: [email, email_technical_secretary], subject: 'Correo de prueba para nuestro mailer')
	  end

end
