json.array!(@settings) do |setting|
  json.extract! setting, :id, :name, :desc, :value
end
