class ClicksController < ApplicationController
  before_action :authenticate_user

  def index
    wheres = []
    if params[:country].present?
      country = '%'.concat(params[:country].capitalize.concat('%'))
      wheres << "country like '#{country}'"
    end
    wheres << "occurred_at >='#{params[:from]}'" if params[:from].present?
    wheres << "occurred_at <='#{params[:to]}'" if params[:to].present?

    query = wheres.join(' and ')
    page = params[:page].to_i
    size = params[:size].to_i
    size = size.positive? ? size : 5

    total = Click.where(query).joins(:link).where(links: {user_id: current_user.id}).length
    clicks = Click.where(query).joins(:link)
                 .where(links: {user_id: current_user.id}).limit(size).offset(page * size)

    render json: ClickSerializer.new(clicks, {is_collection: true, meta: {total: total}})
  end
end
