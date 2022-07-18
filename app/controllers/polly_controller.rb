require 'aws-sdk-polly'
require 'active_record'
class PollyController < ApplicationController
  def index
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def convert 
    loggedUser = "Mathieu"
    elevators = Elevator.count
    buildings = Building.count
    customers = Customer.count
    runEl = Elevator.where({ elevator_status: ["intervention", "inactive"]}).count
    quotes = Quote.count
    leads = Lead.count
    batteries = Battery.count
    cities = Address.distinct.count("city")

    filename = "Briefing"
    polly = Aws::Polly::Client.new(
        region: 'us-east-1',
        access_key_id: 'AKIASWUP4G3IWV7FID43',
        secret_access_key: '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'
    )

    resp = polly.synthesize_speech({
        engine: "standard", 
        output_format: "mp3", 
        text: 
        "Greetings #{loggedUser}. There are currently #{elevators} elevators deployed in the #{buildings} buildings of 
        your #{customers} customers. Currently, #{runEl} elevators are not in Running Status and are being serviced.
        You currently have #{quotes} quotes awaiting processing. You currently have #{leads} leads in your contact requests.
        #{batteries} Batteries are deployed across #{cities} cities. Also, Peter Pan thinks Patrick should buy coffee soon.", 
        voice_id: "Emma",
      })

    # Split up name so we get just the xyz part
    mp3_file = "app/assets/audios/" + filename + '.mp3'

    IO.copy_stream(resp.audio_stream, mp3_file)
    #send_file "#{params[:text]}.mp3
    end
end
