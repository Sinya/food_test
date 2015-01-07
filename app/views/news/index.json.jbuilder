json.array!(@news) do |news|
  json.extract! news, :id, :title, :category, :time
  json.url news_url(news, format: :json)
end
