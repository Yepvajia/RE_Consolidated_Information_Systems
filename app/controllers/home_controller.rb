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

    @lead = Lead.new(params.permit(:name, :company_name, :email, :phone, :project_name , :description , :department , :message , :file , :date))

    if @lead.save
      redirect_to root_path, notice: "Contact successfully submitted."
    else
      render plain: @lead.errors.full_messages
    end

    
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
