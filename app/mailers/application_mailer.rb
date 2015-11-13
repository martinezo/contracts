class ApplicationMailer < ActionMailer::Base
  default from: "genomma@live.com"
  #layout 'mailer'
	  def send_mail(email)
	  	file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"
		@mail_secretary = file_yaml["production"]['e_mail_technical_secretary']
			
	  	email.insert(0,@mail_secretary+",")
	  	puts "eeeeeemaaaaaaaillllll!!!!!!!!"
	  	puts email
		#@user = user
		#@url  = 'http://codeHero.co'
		#email.each do |correo|
		mail(to: email, subject: 'Esta es una notificacion de prueba del sistema UNAM')
		#end 
	end

end
