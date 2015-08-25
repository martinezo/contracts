class ApplicationMailer < ActionMailer::Base
  default from: "genomma@live.com"
  #layout 'mailer'
  
	  def send_mail(email)
		#@user = user
		#@url  = 'http://codeHero.co'
		mail(to: email, subject: 'Aprende a programar con nuestros cursos gratis')
	  end

end
