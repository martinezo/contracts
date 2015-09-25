class ApplicationMailer < ActionMailer::Base
  default from: "genomma@live.com"
  #layout 'mailer'
	  def send_mail(email)
	  	email.insert(0,"#{APP_CONFIG["production"][:e_mail_technical_secretary]}")
	  	puts "eeeeeemaaaaaaaillllll!!!!!!!!"
	  	puts email
		#@user = user
		#@url  = 'http://codeHero.co'
		#email.each do |correo|
		mail(to: email, subject: 'Correo de prueba para nuestro mailer')
		#end 
	end

end
