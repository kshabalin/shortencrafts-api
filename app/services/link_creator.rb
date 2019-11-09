class LinkCreator < ApplicationService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    link = find_by_hash(@params[:url_hash])
    link.present? ? link : create
  end

  private

  def find_by_hash(hash)
    links = Link.find_by_url_hash(hash)
    links.present? ? links[0] : nil
  end

  def create
    @user.present? ? @user.links.create(@params) : Link.create(@params)
  end
end
