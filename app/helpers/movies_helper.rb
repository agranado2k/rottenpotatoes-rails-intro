module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def title_filter?(filter)
    filter == "title"
  end
  
  def release_date_filter?(filter)
    filter == "release_date"
  end
end
