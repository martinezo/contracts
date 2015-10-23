module Google_Calendar
    extend ActiveSupport::Concern

    module ClassMethods
   
  def event_insert(time_min_param,time_max_param,summary_param,location_param)
			file_yaml = YAML.load_file "#{Rails.root}/config/config.yml"
			
			@key = file_yaml["production"][:developper_id]
		    @path_key = 'C:/unam-b563e3112a76.p12';
			@cuenta_developper = '109856604582-208qmf2tc8gbqpki4hkajgsl2mgh3va5@developer.gserviceaccount.com';
			@calendar_id = 'java4ever.sys@gmail.com';
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
				  'dateTime' => @time_min
			   },
			   'end' => {
				  'dateTime' => @time_max
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
		@path_key = 'C:/Sites/google-calendar-ruby/unam-b563e3112a76.p12';
		@cuenta_developper = '109856604582-208qmf2tc8gbqpki4hkajgsl2mgh3va5@developer.gserviceaccount.com';
		@calendar_id = 'java4ever.sys@gmail.com';		
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
			  'dateTime' => @time_min
		   },
		   'end' => {
			  'dateTime' => @time_max
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



	@path_key = 'C:/Sites/google-calendar-ruby/unam-b563e3112a76.p12';
	@cuenta_developper = '109856604582-208qmf2tc8gbqpki4hkajgsl2mgh3va5@developer.gserviceaccount.com';
	@calendar_id = 'java4ever.sys@gmail.com';	
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
      end
end
