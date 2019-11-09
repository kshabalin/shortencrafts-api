class ClicksExtractor < Extractor

  def call
    clicks = clicks_by_country

    clicks = clicks.where('clicks.occurred_at >= ?', @params[:from]) if @params[:from].present?
    clicks = clicks.where('clicks.occurred_at <= ?', @params[:to]) if @params[:to].present?

    { total: total(clicks), clicks: paginated(clicks) }
  end

  private

  def total(clicks)
    clicks.joins(:link).where(links: { user_id: @user.id }).length
  end

  def paginated(clicks)
    clicks.joins(:link)
          .where(links: { user_id: @user.id })
          .limit(size).offset(page * size)
  end

  def clicks_by_country
    if @params[:country].present?
      Click.by_country('%'.concat(@params[:country].capitalize.concat('%')))
    else
      Click.default
    end
  end
end
