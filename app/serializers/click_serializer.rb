class ClickSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :country, :country_code

  attribute :date do |object|
    "#{object.occurred_at.strftime('%Y-%m-%d')}"
  end

  attribute :link do |object|
    LinkSerializer.new(object.link).as_json['data']
  end
end
