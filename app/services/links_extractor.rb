class LinksExtractor < Extractor
  def call
    { total: total, links: paginated}
  end

  private

  def total
    @user.links.count
  end

  def paginated
    @user.links.limit(size).offset(page * size)
  end
end
