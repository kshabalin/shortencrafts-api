class Extractor < ApplicationService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call; end

  private

  def total; end

  def paginated; end

  def page
    page = @params[:page].to_i
    page.positive? ? page : 0
  end

  def size
    size = @params[:size].to_i
    size.positive? ? size : 5
  end
end
