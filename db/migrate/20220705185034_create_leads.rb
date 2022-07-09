class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :company_name
      t.string :email
      t.string :phone
      t.string :project_name
      t.text :description
      t.string :department
      t.text :message
      t.binary :file
      t.date :date

      t.timestamps
    end
  end
end
