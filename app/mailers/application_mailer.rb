class ApplicationMailer < ActionMailer::Base
  default from: "genomma@live.com"
  #layout 'mailer'
  def send_mail(email, system_contract, notification_type, start_date, end_date)
      @email=email
      @system_contract = system_contract
      @start_date = start_date
      @end_date = end_date
    
	  	file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"
		  @mail_secretary = file_yaml["production"]['e_mail_technical_secretary']
      @notification_type = notification_type
    
	  	email.insert(0,@mail_secretary+",")
	  	puts "eeeeeemaaaaaaaillllll!!!!!!!!"
	  	puts email
      
      puts 'description contrato!!!!!!'
      puts @system_contract.description
      puts 'description contrato!!!!!!'
    

		#@user = user
		#@url  = 'http://codeHero.co'
		#email.each do |correo|
    file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"
    @before_days = file_yaml["production"]['notification_time'].to_i.days

    case notification_type
      when "create_contract"
      @header = @system_contract.contract_no.to_s
      @contenido = @system_contract.description.to_s
      @fecha = "Fecha inicial: " + @start_date.to_s + " Fecha final: " + @end_date.to_s
      @config_text_contract = file_yaml["production"]['e_mail_create_contract'].to_s
      mail(to: @email, subject: 'Creacion de contracto con el INB')
    when "update_contract"
      @header = @system_contract.contract_no.to_s 
      @contenido = @system_contract.description 
      @fecha = "Fecha inicial: " + @start_date.to_s + " Fecha final: " + @end_date.to_s
      @config_text_contract = file_yaml["production"]['e_mail_update_contract'].to_s
      mail(to: @email, subject: 'Actualizacion de contracto con el INB')
    when "create_renewal"
      @header =  @system_contract.contract_no
      @contenido = @system_contract.description 
      @fecha = "Fecha inicial: " + @start_date.to_s + "     Fecha final: " + @end_date.to_s
      @config_text_contract = file_yaml["production"]['e_mail_create_renewal'].to_s
      mail(to: @email, subject: 'Creacion de renovacion con el INB')
    when "update_renewal"
      @header = @system_contract.contract_no + 
      @contenido = @system_contract.description
      @fecha = "Fecha inicial: " + @start_date.to_s + "     Fecha final: " + @end_date.to_s
      @config_text_contract = file_yaml["production"]['e_mail_update_renewal'].to_s
      mail(to: @email, subject: 'Actualizacion de renovacion con el INB')
    when "create_siteview"
      @header = @system_contract.contract_no
      @contenido = @system_contract.description
      @fecha = "Fecha de visita: " + @start_date.to_s
      @config_text_contract = file_yaml["production"]['e_mail_create_siteview'].to_s
      mail(to: @email, subject: 'Creacion de visita con el INB')
    when "update_siteview"
      @header = @system_contract.contract_no
      @contenido = @system_contract.description
      @fecha = "Fecha de visita:" + @start_date.to_s
      @config_text_contract = file_yaml["production"]['e_mail_update_siteview'].to_s
      mail(to: @email, subject: 'Actualizacion de visita con el INB')
    end
	end

end
