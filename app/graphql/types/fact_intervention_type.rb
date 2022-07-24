module Types
    class FactInterventionType < GraphQL::Schema::Object
        implements GraphQL::Types::Relay::Node

        field :id, ID, null: false
        field :employee_id, Integer, null: false
        field :building_id, Integer, null: false
        field :baterry_id, [Integer], null: false
        field :column_id, [Integer], null: false
        field :elevator_id, [Integer], null: false
        field :start_date, String, null: false
        field :end_date, String, null: false
        field :result, String, null: false
        field :report, String, null: false
        field :status, String, null: false

        field :buildingaddress,[Types::BuildingType], null: false

        def buildingaddress
            # var addressId = Building.find(:id)
            return Building.where(address_id: 1)
        end

        field :buildingintervention, [Types::BuildingType], null: false

        def buildingintervention
            return Building.where(id: "1")
        end
        
        # field :customeridforintervention, [Types]

    end
end
