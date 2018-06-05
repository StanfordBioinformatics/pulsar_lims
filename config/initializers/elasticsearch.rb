#heroku Elasticsearch::Transport::Transport::Errors::Unauthorized

#Elasticsearch::Model.client = Elasticsearch::Client.new url: "https://#{URI::encode(ENV['ES_USER'])}:#{URI::encode(ENV['ES_PASSWORD'])}@#{ENV['FOUNDELASTICSEARCH_URL'].split('https://')[1]}"

if ENV.include?("PROD")
  Elasticsearch::Model.client = Elasticsearch::Client.new hosts: [{
    host: ENV["FOUNDELASTICSEARCH_URL"],
    port: 9243,
    user: URI::encode(ENV["ES_USER"]),
    password: URI::encode(ENV["ES_PASSWORD"])
  }]
else
  Elasticsearch::Model.client = Elasticsearch::Client.new host: "http://localhost:9200"
end
