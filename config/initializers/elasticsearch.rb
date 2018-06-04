#heroku Elasticsearch::Transport::Transport::Errors::Unauthorized
Elasticsearch::Model.client = Elasticsearch::Client.new url: "https://#{URI::encode(ENV['ES_USER'])}:#{URI::encode(ENV['ES_PASSWORD'])}@#{ENV['FOUNDELASTICSEARCH_URL'].split('https://')[1]}"
