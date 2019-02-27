module Response
  def json_response(object, status = :ok)
    # render json: object, status: status, each_serializer: CustomerExchangeSerializer
    get_class = object.try(:klass) || object.class
    class_name = get_class.name
    response_object = if class_name == "Hash"
               object
             else
               options = {}
               options[:is_collection] = nil
               serializer_class = class_name + "Serializer"
               serializer_class.constantize.new(object, options).serialized_json
             end
    render json: response_object, status: status
  end
end
