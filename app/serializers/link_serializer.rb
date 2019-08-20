class LinkSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :created_at, :url_hash, :url

  attribute :short_url do |object|
    "http://toylink.xyz/#{object.url_hash}"
  end

  attribute :clicks do |object|
    object.clicks.count
  end
end
