module NoticeImagesHelper
  def years_between_dates(start_date, end_date)
    (end_date.year - start_date.year).to_i
  end
end
