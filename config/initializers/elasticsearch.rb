#heroku Elasticsearch::Transport::Transport::Errors::Unauthorized
Elasticsearch::Model.client = Elasticsearch::Client.new url: "https://#{ENV['ES_USER']}:#{ENV['ES_PASSWORD']}@#{ENV['FOUNDELASTICSEARCH_URL'].split('https://')[1]}"
