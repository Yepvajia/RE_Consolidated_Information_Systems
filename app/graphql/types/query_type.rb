module Types
  class QueryType < Types::BaseObject
    implements  GraphQL::Types::Relay::Node

    
      # Add root-level fields here.
     # They will be entry points for queries on your schema.

      # TODO: remove me
      field :test_field, String, null: false,
        description: "An example field added by the generator"
      def test_field
        "Hello World!"
      end

      field :factinterventiontype, [Types::FactInterventionType], null: false do
        argument :employee_id, Integer, required: false
      end

      def factinterventiontype(employee_id:)
        FactIntervention.where(employee_id: "5")
      end

      field :buildingtype, [Types::BuildingType], null: false, description: "building table"

      def buildingtype
        Building.where(address_id: "1")
      end

      field :customertype, [Types::CustomerType], null: false, description: "customer table"

      def customertype
        Customer.where(id: "1", address_id: "1")
      end
      
  end
end
