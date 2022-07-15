require 'dropbox_api'

class HomeController < ApplicationController

  def index
    # if current_user
    #   redirect_to rails_admin_path
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
    # blob = @lead.file.blob.download
    puts 'START OF DROPBOX PROCESS'
    if @lead.file.attached?
      puts @lead.file.attached?
      dbx = DropboxApi::Client.new(ENV['DROPBOX_OAUTH_BEARER'])
      puts 'AUTHENTICATED'
      filename_path = ActiveStorage::Blob.service.send(:path_for, @lead.file.key)
      puts "YOOOOOOOOOOOO"
      puts filename_path
      new_filename = "#{@lead.company_name.parameterize}/#{@lead.file.filename.to_s}"
      puts "HEEEEEEEEEEEEEEEEEEEY"
      puts new_filename
      file = dbx.upload(new_filename, 'https://www.dropbox.com/home/Apps/RocketElevatorFileHolder') # Accepts a String or File
      puts 'FILES IN DROPBOX APP'
    end
    # file.open
    # puts 'OPEN FILE PLEASE'
    # file.class # => Dropbox::FileMetadata
    # file.size # => 17
    # file.rev # => a1c10ce0dd78

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

  end

end

