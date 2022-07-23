module Types
  class QueryType < Types::BaseObject
    
      # Add root-level fields here.
     # They will be entry points for queries on your schema.

      # TODO: remove me
      field :test_field, String, null: false,
        description: "An example field added by the generator"
      def test_field
        "Hello World!"
      end

      field :factinterventiontype, [Types::FactInterventionType], null: false, description: "fact_intervention" 

      def factinterventiontype
        FactIntervention.all
      end

      field :buildingtype, [Types::BuildingType], null: false, description: "building table"

      def buildingtype
        Building.all
      end

      field :customertype, [Types::CustomerType], null: false, description: "customer table"

      def customertype
        Customer.all
      end
  end
end
