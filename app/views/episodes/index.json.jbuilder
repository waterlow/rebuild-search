json.array!(@episodes) do |episode|
  json.extract! episode, :title, :contributor_text, :show_note_full_text, :show_notes, :description, :identifier, :id
  json.url episodes_url(format: :json)
end
