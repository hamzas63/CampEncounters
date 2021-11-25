module SearchSort
  extend ActiveSupport::Concern

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end

  def pagy_search_sort(query, klass)
    records = klass.all
    records = records.order(sort_column + ' ' + sort_direction) if sort_column and sort_direction
    records = records.search(query) if query.present?
    pagy(records, items: 3)
  end
end
