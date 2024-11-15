# config/initializers/openai.rb
OpenAI.configure do |config|
    config.access_token = ENV['OPENAI_API_KEY']
  end
  