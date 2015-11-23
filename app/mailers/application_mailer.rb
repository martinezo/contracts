class ApplicationMailer < ActionMailer::Base
  default from: "genomma@live.com"
  #layout 'mailer'
	  def send_mail(email, system_contract)
      @email=email
      @system_contract = system_contract
	  	file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"
		  @mail_secretary = file_yaml["production"]['e_mail_technical_secretary']
			
	  	email.insert(0,@mail_secretary+",")
	  	puts "eeeeeemaaaaaaaillllll!!!!!!!!"
	  	puts email
      
      puts 'description contrato!!!!!!'
      puts @system_contract.description
      puts 'description contrato!!!!!!'
		#@user = user
		#@url  = 'http://codeHero.co'
		#email.each do |correo|
		mail(to: @email, subject: 'UNAM')
		#end 
	end

end
