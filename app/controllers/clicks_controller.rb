class ClicksController < ApplicationController
  before_action :authenticate_user

  def index
    extracted = ClicksExtractor.call(params, current_user)
    render json: ClickSerializer.new(extracted[:clicks],
                                     is_collection: true,
                                     meta: { total: extracted[:total] })
  end
end
