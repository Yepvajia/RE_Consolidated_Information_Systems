require 'sendgrid-ruby'
include SendGrid
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

    @lead = Lead.new(params.permit(:name, :company_name, :email, :phone, :project_name , :description , :department , :message , :file , :date))
    @params_email = params.permit(:email, :name, :project_name)

    if @lead.save
      send_mail(@params_email)
      redirect_to root_path, notice: "Contact successfully submitted."
    else
      render plain: @lead.errors.full_messages
    end
  end

  def send_mail(params_email)
    email = params_email['email']
    name = params_email['name']
    project_name = params_email['project_name']

    from = Email.new(email: 'sevada.rostomian@gmail.com')
    to = Email.new(email: email)
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
    mail = Mail.new(from, subject, to, content)



    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers

  end
end
