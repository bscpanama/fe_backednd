module Response
  def json_response(object, status = :ok)
    # render json: object, status: status, each_serializer: CustomerExchangeSerializer
    get_class = object.try(:klass) || object.class
    class_name = get_class.name
    response_object = if class_name == "Hash"
               object
             else
               serializer_class = (class_name + "Serializer").constantize
               options = {}
               options[:is_collection] = nil
               options[:meta] = [pages: (class_name.constantize.count)/8.ceil]
               serializer_class.new(object, options).serialized_json
             end
    render json: response_object, status: status
  end
end
