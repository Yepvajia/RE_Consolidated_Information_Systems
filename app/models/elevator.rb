require 'twilio-ruby'


class Elevator < ApplicationRecord
  include ActiveModel::Dirty
  belongs_to :column, class_name: "Column", foreign_key: "column_id"
  before_update :sendSms

  puts 'HEY'

  def sendSms
    puts "noooo" 
    if self.elevator_status_changed?
      puts 'look here'
      if self.elevator_status == 'intervention'
        puts 'and here'
        account_sid = ENV['TWILIO_ID']
        auth_token = ENV['TWILIO_PASS']
        @client = Twilio::REST::Client.new(account_sid, auth_token) 
        puts 'and why not here'
            message = @client.messages.create(
                 body: 'Elevator needs attention!',
                 from: '+16067332745',
                 to: '+15146616283'
                 )
      end
    end     
  end
end