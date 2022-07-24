module Types
    class CustomerType < GraphQL::Schema::Object
        implements GraphQL::Types::Relay::Node

        field :id, ID, null:false
        field :user_id, Integer, null: false
        field :creation_date, String, null: false
        field :company_name, String, null: false
        field :address_id, Int, null: false
        field :phone, Integer, null: false
        field :email, String, null: false
        field :description, String, null: false
        field :auth_name, Integer, null: false
        field :auth_phone, String, null: false
        field :mangr_email, String, null: false
        field :created_at, String, null: false
        field :updated_at, String, null: false

        field :interventionelevator, [Types::FactInterventionType], null: false

        def interventionelevator
            FactIntervention.where(building_id: "1")
        end

        field :interventionelevator2building, [Types::BuildingType], null: false

        def interventionelevator2building
            Building.where(address_id: "1")
        end
    end

end