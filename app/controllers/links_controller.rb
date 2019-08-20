class LinksController < ApplicationController
  require 'iplocate'
  DEFAULT_REDIRECT_URL = 'https://www.bing.com'
  before_action :authenticate_user, only: [:index, :destroy]

  def create
    user = current_user
    if user.present?
      if user.links.create(link_params)
        render json: LinkSerializer.new(user.links.last), status: 201
      else
        render json: {errors: link.errors}, status: :unprocessable_entity
      end
    else
      link = Link.new(link_params)
      if link.save
        render json: LinkSerializer.new(link), status: 201
      else
        render json: {errors: link.errors}, status: :unprocessable_entity
      end
    end
  end

  def index
    user = current_user
    page = params[:page].to_i
    size = params[:size].to_i
    size = size.positive? ? size : 5
    total = user.links.count
    links = user.links.limit(size).offset(page * size)
    render json: LinkSerializer.new(links, {is_collection: true, meta: {total: total}})
  end

  def destroy
    link = Link.find(params[:id])
    link.destroy
    render json: link, status: 204
  end

  def redirect
    if params[:url_hash]
      link = Link.find_by_url_hash(params[:url_hash])
      if link.nil?
        redirect_to DEFAULT_REDIRECT_URL and return
      else
        result = IPLocate.lookup(request.ip)
        country = result['country'] || 'no country'
        country_code = result['country_code'] || 'no code'
        click = link.clicks.new(country: country, country_code: country_code)
        if click.save
          redirect_to(link.url) and return
        else
          render json: {errors: click.errors}, status: :expectation_failed
        end
      end
    end
    redirect_to DEFAULT_REDIRECT_URL
  end

  private

  def link_params
    params.require(:link).permit(:url_hash, :url)
  end

  def find_link id
    Link.select(:url_hash, :url).where(id: id)
  end
end
