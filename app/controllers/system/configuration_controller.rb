# encoding: UTF-8
class System::ConfigurationController < ApplicationController
  def configure
  	@configuration_fields = YAML.load_file "#{Rails.root}/config/config.yml"
  	@mailers = @configuration_fields["production"]
  	#@configuration_fields = "#{APP_CONFIG[:technical_secretary][:e_mail]}"
  end

  def edit
  	puts "XXXXXXXXXXXXXXXX#{@mailers.class}"
  	#@edit_mailers = @mailers
  	@edit_name = params[:name_param]
  	@edit_email = params[:mail_param]
  end

  def save
    @file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"
    #La linea de abajo sirve para depurar la cadena en caso de que marque algun error de codificación
    #Al parecer no acepta acentos.
    @file_yaml["production"][:name_technical_secretary] = params[:name].encode("UTF-8", "binary", :invalid => :replace, :undef => :replace, :replace => "?")
    #@file_yaml["production"][:name_technical_secretary] = params[:name]
    @file_yaml["production"][:e_mail_technical_secretary] = params[:e_mail]
    #@file_yaml["production"][:name_technical_secretary] = params[:name].encode(Encoding::UTF_8)
    #@file_yaml["test"] = @var_prueba.encode(Encoding::ISO_8859_1)
    #@file_yaml.force_encoding('ISO-8859-1')
    #@file_yaml.to_hash
    @file_yaml.to_yaml
    puts "Prueba para el Save #{@file_yaml}"
    File.open("#{Rails.root}/config/config.yml", 'w+') { |f| YAML.dump(@file_yaml, f)}


  end
end
