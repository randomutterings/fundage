json.array!(@entries) do |entry|
  json.extract! entry, :id, :debits, :credits
  json.url entry_url(entry, format: :json)
end
