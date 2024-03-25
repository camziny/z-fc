class PaginationWrapper
  attr_reader :total_pages, :current_page

  def initialize(pagination_info)
    @total_pages = pagination_info['pageTotal']
    @current_page = pagination_info['pageCurrent']
  end

  def total_pages
    @total_pages
  end
end
