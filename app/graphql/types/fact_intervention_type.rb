module Types
    class FactInterventionType < Types::BaseObject
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
            return Building.where(address_id: 5)
        end

        field :buildingintervention, [Types::BuildingType], null: false

        def buildingintervention
            Building.where(id: BuildingType)
        end
        
        # field :customeridforintervention, [Types]

    end
end
