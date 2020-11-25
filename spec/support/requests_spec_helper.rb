module RequestsSpecHelper
  def json_headers
    {
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }
  end

  def token_headers
    json_headers.merge(Authorization: "#{try(:token)}")
  end

  def body
    JSON.parse(response.body, symbolize_names: true) rescue {}
  end

  def body_errors
    body[:errors]
  end
end

RSpec.configure do |config|
  config.include RequestsSpecHelper
end
