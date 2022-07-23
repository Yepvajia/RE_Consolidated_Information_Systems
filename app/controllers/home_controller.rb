require 'sendgrid-ruby'
include SendGrid
require 'dropbox_api'
require 'rest-client'
require "json"

class HomeController < ApplicationController

  def index
    # if current_user
    #   if current_user.admin == 1
    #     redirect_to rails_admin_path
    #   end
    # end
  end
  
  def chart 
    if current_user.admin != 1
        redirect_to root_path
    end
  end


  def create_lead
    pp params[:file]
    @lead = Lead.new(params.permit(:name, :company_name, :email, :phone, :project_name , :description , :department , :message , :file , :date))
    @params_email = params.permit(:email, :name, :project_name)

    puts 'START OF DROPBOX PROCESS'
    if @lead.file.attached?
      puts @lead.file.attached?
      dbx = DropboxApi::Client.new(ENV['DROPBOX_OAUTH_BEARER'])
      puts 'AUTHENTICATED'
      filename_path = ActiveStorage::Blob.service.send(:path_for, @lead.file.key)
      puts "YOOOOOOOOOOOO"
      pp filename_path
      new_filename = "#{@lead.company_name.parameterize}/#{@lead.file.filename.to_s}"
      puts "HEEEEEEEEEEEEEEEEEEEY"
      puts new_filename
      file = dbx.upload(filename_path, 'https://www.dropbox.com/home/Apps/RocketElevatorFileHolder') # Accepts a String or File
      puts 'FILES IN DROPBOX APP'
    end

    if @lead.save
      send_mail(@params_email)
      redirect_to root_path, notice: "Contact successfully submitted."
      data = {
        email: "#{@lead.email}", 
        priority: 1, 
        status: 2,
        type: "Question",
        subject: "#{@lead.name} from #{@lead.company_name}",
        description: "The contact #{@lead.name} from company #{@lead.company_name} can be reached at email #{@lead.email} and at phone number #{@lead.phone}. 
        #{@lead.department} has a project named #{@lead.project_name} which would require contribution from Rocket Elevators. 
        #{@lead.description}",
      }.to_json
      request  = RestClient::Request.execute(
        method: :post, 
        url: 'https://rocketelevator-support.freshdesk.com/api/v2/tickets',
        user: ENV['FRESHDESK_KEY'],
        password: "x",
        headers: {
          content_type: "application/json"
        },
        payload: data
      )
    else
      render plain: @lead.errors.full_messages
    end
    
    if @lead.file.attached?
      dbx = DropboxApi::Client.new(ENV['DROPBOX_OAUTH_BEARER'])
      filename_path = ActiveStorage::Blob.service.send(:path_for, @lead.file.key)
      new_filename = "#{@lead.company_name.parameterize}/#{@lead.file.filename.to_s}"
      file = dbx.upload(new_filename, 'https://www.dropbox.com/home/Apps/RocketElevatorFileHolder') # Accepts a String or File
    end
  end

  def send_mail(params_email)
    email = params_email['email']
    name = params_email['name']
    project_name = params_email['project_name']
    from = SendGrid::Email.new(email: 'sevada.rostomian@gmail.com')
    to = SendGrid::Email.new(email: email)
    subject = 'Response to contact.'
    content = Content.new(type: 'text/html', value: 'Greetings ' + name +
      ',<br>
      <br>
      We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project ' + project_name + '.
      <br>
      <br>
      A representative from our team will be in touch with you very soon. We look forward to demonstrating the value of our solutions and helping you choose the appropriate product given your requirements.
      <br>
      <br>
      We’ll Talk soon
      <br>
      The Rocket Team
      <br>
      <br>
      <img src="https://i.imgur.com/M5G13C8.png" width="200">')
    mail = SendGrid::Mail.new(from, subject, to, content)


    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end

