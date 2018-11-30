#heroku Elasticsearch::Transport::Transport::Errors::Unauthorized

#Elasticsearch::Model.client = Elasticsearch::Client.new url: "https://#{URI::encode(ENV['ES_USER'])}:#{URI::encode(ENV['ES_PW'])}@#{ENV['FOUNDELASTICSEARCH_URL'].split('https://')[1]}"

if ENV.include?("PROD")
  Elasticsearch::Model.client = Elasticsearch::Client.new hosts: [{
    host: ENV["FOUNDELASTICSEARCH_URL"].split("https://")[1],
    user: ENV["ES_USER"],
    port: "9243",
    password: ENV["ES_PW"],
    scheme: "https"
  }]
else
  Elasticsearch::Model.client = Elasticsearch::Client.new host: "http://localhost:9200"
end
