class RedirectHandler < ApplicationService
  require 'iplocate'

  def initialize(url_hash, ip)
    @url_hash = url_hash
    @ip = ip
  end

  def call
    link = find_link
    if link.nil?
      default_redirect
    else
      create_click link
      link.url
    end
  end

  private

  def find_link
    Link.find_by_url_hash(@url_hash)
  end

  def create_click(link)
    country = define_country
    link.clicks.create(country: country[:country],
                       country_code: country[:code],
                       occurred_at: DateTime.now)
  end

  def define_country
    result = IPLocate.lookup(@ip)
    { country: result['country'] || 'no country', code: result['country_code'] || 'no code' }
  end

  def default_redirect
    Figaro.env.default_redirect_url
  end
end
