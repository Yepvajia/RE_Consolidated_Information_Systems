require 'twilio-ruby'

class Elevator < ApplicationRecord
  include ActiveModel::Dirty
  belongs_to :column, class_name: "Column", foreign_key: "column_id"
  before_update :sendSms

def sendSms
  if self.elevator_status_changed?
    if self.elevator_status == 'intervention'
      account_sid = ENV['TWILIO_ID']
      auth_token = ENV['TWILIO_PASS']
      @client = Twilio::REST::Client.new(account_sid, auth_token)
        from: ENV['TWILIO_PHONE']
        to: ENV['TECH_PHONE'] 
          message = @client.messages.create(
               body: 'Elevator needs attention!',
               from: from,
               to: to
               )
    end
  end     
end
end