class ClicksExtractor < Extractor

  def call
    clicks = clicks_by_country
    clicks = from_date(clicks)
    clicks = to_date(clicks)

    { total: total(clicks), clicks: paginated(clicks) }
  end

  private

  def total(clicks)
    clicks.joins(:link).where(links: { user_id: @user.id }).length
  end

  def from_date(clicks)
    @params[:from].present? ? clicks.from_occurred_at(@params[:from]) : clicks
  end

  def to_date(clicks)
    @params[:to].present? ? clicks.to_occurred_at(@params[:to]) : clicks
  end

  def paginated(clicks)
    clicks.joins(:link)
          .where(links: { user_id: @user.id })
          .limit(size).offset(page * size)
  end

  def clicks_by_country
    if @params[:country].present?
      Click.by_country('%'.concat(@params[:country].concat('%')))
    else
      Click.default
    end
  end
end
