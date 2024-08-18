module App::NoticesHelper
  def current_page_params
    request.params.slice("q", "filter", "sort", "page", "per_page")
  end
end
