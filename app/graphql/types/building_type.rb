module Types
    class BuildingType < Types::BaseObject
        field :id, ID, null:false
        field :customer_id, Integer, null: false
        field :address_id, Integer, null: false
        field :name, String, null: false
        field :email, String, null: false
        field :phone, Integer, null: false
        field :tech_name, String, null: false
        field :tech_email, String, null: false
        field :tech_phone, Integer, null: false
        field :intervention_for_building, [Types::FactInterventionType], null: false

        def intervention_for_building
            FactIntervention.where(start_date: start_date, end_date: end_date)
        end
        
    end
end
