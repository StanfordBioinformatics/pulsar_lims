Article.__elasticsearch__.client = Elasticsearch::Client.new host: ENV["FOUNDELASTICSEARCH_URL"]
