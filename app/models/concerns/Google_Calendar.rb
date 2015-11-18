module Google_Calendar
    extend ActiveSupport::Concern

    module ClassMethods
   
	def event_insert(time_min_param,time_max_param,summary_param,location_param)
			
			file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"

			@key = file_yaml["production"]['developper_key']
		  	@path_key = file_yaml["production"]['key_path_p12']
			@cuenta_developper = file_yaml["production"]['developper_email']
			@calendar_id = file_yaml["production"]['calendar_id']
			@time_min = time_min_param;
			@time_max = time_max_param;
			@location = location_param;
			@summary = summary_param;
			@client = Google::APIClient.new(:key => @key);
			path_to_key_file = @path_key;
			passphrase = 'notasecret';
			key = Google::APIClient::PKCS12.load_key(path_to_key_file, passphrase)
			asserter = Google::APIClient::JWTAsserter.new(
					@cuenta_developper,
					'https://www.googleapis.com/auth/calendar',
					key)
			# To request an access token, call authorize:
			@client.authorization = asserter.authorize()

			calendar = @client.discovered_api('calendar', 'v3')

			event = {
			  'summary' => @summary,
			  'location' => @location,
			  'start' => {
				  'dateTime' => @time_min,
				  'timeZone' => 'America/Mexico_City'	
			   },
			   'end' => {
				  'dateTime' => @time_max,
				  'timeZone' => 'America/Mexico_City'
				},
				'attendees' => [
					{
					  'email' => 'java4ever.sys@gmail.com'
					},
					#...
				  ]
			   }

			result = @client.execute!(:api_method => calendar.events.insert,
										:parameters => {calendarId: @calendar_id},
										:body => JSON.dump(event),
										:headers => {'Content-Type' => 'application/json'})
			
			return result.data.id
			end
			
	def event_update(time_min_param,time_max_param,summary_param,location_param,event_id_param)
		file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"

			@key = file_yaml["production"][:developper_id]
			@path_key = file_yaml["production"]['key_path_p12']
			@cuenta_developper = file_yaml["production"]['developper_email']
			@calendar_id = file_yaml["production"]['calendar_id']		
			@time_min = time_min_param;
			@time_max = time_max_param;
			@location = location_param;
			@summary = summary_param;
			@event_id = event_id_param;

			@client = Google::APIClient.new(:key => @key)
			path_to_key_file = @path_key
			passphrase = 'notasecret'
			key = Google::APIClient::PKCS12.load_key(path_to_key_file, passphrase)
			asserter = Google::APIClient::JWTAsserter.new(
					@cuenta_developper,
					'https://www.googleapis.com/auth/calendar',
					key)
			# To request an access token, call authorize:
			@client.authorization = asserter.authorize()

			calendar = @client.discovered_api('calendar', 'v3')

			event = {
			  'summary' => @summary,
			  'location' => @location,
			  'start' => {
				  'dateTime' => @time_min,
				  'timeZone' => 'America/Mexico_City'
			   },
			   'end' => {
				  'dateTime' => @time_max,
				  'timeZone' => 'America/Mexico_City'
				},
				'attendees' => [
					{
					  'email' => 'java4ever.sys@gmail.com'
					},
					#...
				  ]
			   }

			result = @client.execute!(:api_method => calendar.events.update,
										:parameters => {calendarId: @calendar_id,
														eventId: @event_id},
										:body => JSON.dump(event),
										:headers => {'Content-Type' => 'application/json'})
	end
	
	def event_delete(event_id_param)
		file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"

		@key = file_yaml["production"][:developper_id]
		@path_key = file_yaml["production"]['key_path_p12']
		@cuenta_developper = file_yaml["production"]['developper_email']
		@calendar_id = file_yaml["production"]['calendar_id']		
		@event_id = event_id_param;

		@client = Google::APIClient.new(:key => @key)
		path_to_key_file = @path_key
		passphrase = 'notasecret'
		key = Google::APIClient::PKCS12.load_key(path_to_key_file, passphrase)
		asserter = Google::APIClient::JWTAsserter.new(
				@cuenta_developper,
				'https://www.googleapis.com/auth/calendar',
				key)
		# To request an access token, call authorize:
		@client.authorization = asserter.authorize()

		calendar = @client.discovered_api('calendar', 'v3')

		result = @client.execute!(:api_method => calendar.events.delete,
									:parameters => {calendarId: @calendar_id,
													eventId: @event_id})
	end

	def event_delete_cascade_contract(contract_id)
		begin
			contrato=System::Contract.find(contract_id)
					@renovaciones.each do |r|
					System::Contract.event_delete(r.google_event_start)
					System::Contract.event_delete(r.google_event_end)
						begin 
							@visitas=r.Siteviews
							@visitas.each do |v|
								System::Contract.event_delete(v.google_event_start)
							end
						rescue
						end
					end
		rescue
		puts 'Se han procesado las eliminaciones del calendario de google en cascada'
	end
  end
    
      def event_delete_cascade_renewal(renewal_id)
      puts 'Este es el renewal_id'
        renewal=System::Renewal.find(renewal_id)
      System::Renewal.event_delete(renewal.google_event_start)
      System::Renewal.event_delete(renewal.google_event_end)
        			begin 
                @visitas=renewal.Siteviews
							@visitas.each do |v|
								System::Renewal.event_delete(v.google_event_start)
							end
						rescue
  end   
  end
      
end
end
