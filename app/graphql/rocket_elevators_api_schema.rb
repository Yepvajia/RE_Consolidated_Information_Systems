class RocketElevatorsApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.id_from_object(object, type_definition, query_ctx)
    # Generate a unique string ID for `object` here
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    object.to_gid_param
  end

  def self.object_from_id(global_id, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    GlobalID.find(global_id)
  end

  def self.resolve_type(type, obj, ctx)
    case obj
    when Building
      Types::BuildingType
    when FactIntervention
      Types::FactInterventionType
    when Customer
      Types::CustomerType
    else
      raise("Unexpected object: #{obj}")
    end
  end
end
