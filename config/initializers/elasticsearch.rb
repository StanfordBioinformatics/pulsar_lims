#Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV["FOUNDELASTICSEARCH_URL"]
Elasticsearch::Model.client = Elasticsearch::Client.new url: "https://#{ENV['EL_USER']}:#{ENV['EL_PASSWORD']}@#{ENV['FOUNDELASTICSEARCH_URL'].split("https://")[1]}"
