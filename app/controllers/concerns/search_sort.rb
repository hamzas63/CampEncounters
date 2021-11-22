module SearchSort
  extend ActiveSupport::Concern

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end

  def pagy_search_sort(query, klass)
    @records = klass.all
    if sort_column and sort_direction
      @records = @records.order(sort_column + ' ' + sort_direction)
    end
    if query.present?
      @records = @records.search(query).all
    end
    @pagy, @records = pagy(@records, items: 3)
  end
end
