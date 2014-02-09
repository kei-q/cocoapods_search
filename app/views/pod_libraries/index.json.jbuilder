json.array!(@pod_libraries) do |pod_library|
  json.extract! pod_library, :id
  json.url pod_library_url(pod_library, format: :json)
end
