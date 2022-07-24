module Types
    class BuildingType < GraphQL::Schema::Object
        implements GraphQL::Types::Relay::Node

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
            FactIntervention.where(start_date: "2022-04-01",end_date: "2022-12-23")
        end

    end
end
