require 'twilio-ruby'
require 'slack-notifier'

class Elevator < ApplicationRecord
  include ActiveModel::Dirty
  belongs_to :column, class_name: "Column", foreign_key: "column_id"
  before_update :sendSms, :howl 




  def sendSms
    if self.elevator_status_changed?
      if self.elevator_status == 'intervention'
        account_sid = ENV['TWILIO_ID']
        auth_token = ENV['TWILIO_PASS']
        @client = Twilio::REST::Client.new(account_sid, auth_token)
          from = ENV['TWILIO_PHONE']
          to = ENV['TECH_PHONE'] 
            message = @client.messages.create(
                body: 'Elevator needs attention!',
                from: from,
                to: to
                )
      end
    end     
  end

  def howl
    if self.elevator_status_changed?
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
        defaults channel: "#general",
                 username: "Lewis, the Howler Monkey"
      end
      notifier.ping "Hello Boss and bosses, the elevator #{self.id} with Serial Number #{self.serial_number} changed
      status from #{self.elevator_status_was} to #{self.elevator_status}"
    end
  end
end