class DucumentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :number, :document_type, :status
end
