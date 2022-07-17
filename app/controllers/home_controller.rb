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

    if @lead.save
      redirect_to root_path, notice: "Contact successfully submitted."
    else
      render plain: @lead.errors.full_messages
    end

    # puts 'LOOOK HERE'
    # pp @lead.file.blob.key
    # blob = @lead.file.blob
    # pp blob
    # --------------------------------------------------#
    # puts 'START OF DROPBOX PROCESS'
    # if @lead.file.attached?
    #   puts @lead.file.attached?
    #   dbx = DropboxApi::Client.new(ENV['DROPBOX_OAUTH_BEARER'])
    #   puts 'AUTHENTICATED'
    #   filename_path = ActiveStorage::Blob.service.send(:path_for, @lead.file.key)
    #   puts "YOOOOOOOOOOOO"
    #   pp filename_path
    #   new_filename = "#{@lead.company_name.parameterize}/#{@lead.file.filename.to_s}"
    #   puts "HEEEEEEEEEEEEEEEEEEEY"
    #   puts new_filename
    #   file = dbx.upload(new_filename, 'https://www.dropbox.com/home/Apps/RocketElevatorFileHolder') # Accepts a String or File
    #   puts 'FILES IN DROPBOX APP'
    # end
    #----------------------------------------------------#
    # insert_query = <<-SQL
    #   INSERT INTO leads (title, body, author, created_at)
    #   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    # SQL

    # connection.execute insert_query,
      # params['name'],
      # params['company_name'],
      # params['email'],
      # params['phone'],
      # params['project_name'],
      # params['description'],
      # params['department'],
      # params['message'],
      # params['file'],
      # params['date']




        # if @lead.save
        #   puts 'listennnnn'
        #   data = {
        #     email: "#{@lead.email}", 
        #     priority: 1, 
        #     status: 2,
        #     type: "Question",
        #     subject: "#{@lead.name} from #{@lead.company_name}",
        #     description: "The contact #{@lead.name} from company #{@lead.company_name} can be reached at email #{@lead.email} and at phone number #{@lead.phone}. 
        #     #{@lead.department} has a project named #{@lead.project_name} which would require contribution from Rocket Elevators. 
        #     #{@lead.description}",
        #   }.to_json
        #   puts data
        #   # puts 'hellooooooooooooo'
        #   # data_json = JSON.generate(data)
        #     # puts data_json
        #     puts "look here"
        #   request  = RestClient::Request.execute(
        #     method: :post, 
        #     url: 'https://rocketelevator-support.freshdesk.com/api/v2/tickets',
        #     user: ENV['FRESHDESK_KEY'],
        #     password: "x",
        #     headers: {
        #       content_type: "application/json"
        #     },
        #     payload: data
        #   )
        #   puts request 
        #   end
  end
end

