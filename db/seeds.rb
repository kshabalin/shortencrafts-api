require 'digest/md5'

countries = [
    {'name': 'Russian Federation', 'code': 'RU'},
    {'name': 'United States', 'code': 'US'},
    {'name': 'Canada', 'code': 'CA'},
    {'name': 'China', 'code': 'CN'},
    {'name': 'Israel', 'code': 'IL'},
    {'name': 'Italy', 'code': 'IT'},
    {'name': 'Jamaica', 'code': 'JM'},
    {'name': 'Malaysia', 'code': 'MY'},
    {'name': 'New Zealand', 'code': 'NZ'},
    {'name': 'Peru', 'code': 'PE'},
    {'name': 'Philippines', 'code': 'PH'},
    {'name': 'Pitcairn', 'code': 'PN'},
    {'name': 'Poland', 'code': 'PL'},
    {'name': 'Portugal', 'code': 'PT'}
]

u = User.create!(username: 'Username', email: 'mail@mail.com', password: '12345678')

countries.each do |county|
  url = "https://www.google.com/search?q=history+of+#{county[:name]}"
  hash = Digest::MD5.hexdigest(url)
  link = u.links.create!(url_hash: hash[0..5], url: url)
  countries.each do |click_country|
    link.clicks.create!(
        country: click_country[:name],
        country_code: click_country[:code],
        occurred_at: rand((DateTime.now - 3.months)..DateTime.now)
    )
  end
end
