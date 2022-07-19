# # Download the helper library from https://www.twilio.com/docs/ruby/install
# require 'rubygems'
# require 'twilio-ruby'
# require_relative './app/models/elevator'
# require_relative './app/models/application_record'
# # Find your Account SID and Auth Token at twilio.com/console
# # and set the environment variables. See http://twil.io/secure
# account_sid = 'AC28f25b0c2c9f0b69a77158d83414a186'
# auth_token = '4585b575ea89399ca0dcca41e1f24348'
# @client = Twilio::REST::Client.new(account_sid, auth_token)

# if Elevator.status = 'intervention'
#     message = @client.messages
#       .create(
#          body: 'Elevator needs intervention!!',
#          from: '+16067332745',
#          to: '+15146616283'
#     )
# end
# puts message.sid
# puts message.status
