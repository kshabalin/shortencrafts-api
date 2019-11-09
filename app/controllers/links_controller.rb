class LinksController < ApplicationController
  before_action :authenticate_user, only: [:index, :destroy]

  def create
    link = LinkCreator.call(link_params, current_user)
    if link.persisted?
      render json: LinkSerializer.new(link), status: 201
    else
      render json: { errors: link.errors }, status: :unprocessable_entity
    end
  end

  def index
    extracted = LinksExtractor.call(params, current_user)
    render json: LinkSerializer.new(extracted[:links],
                                    is_collection: true,
                                    meta: { total: extracted[:total] })
  end

  def destroy
    link = Link.find(params[:id])
    link.destroy
    render json: link, status: 204
  end

  def redirect
    redirect_to RedirectHandler.new(params[:url_hash], request.ip).handle
  end

  private

  def link_params
    params.require(:link).permit(:url_hash, :url)
  end
end
