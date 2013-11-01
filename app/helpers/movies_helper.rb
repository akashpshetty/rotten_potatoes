module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def fetch_header_attrs(header_name)
    temp_hash = {id: "%{header_id}_hdr" % {header_id: header_name}}
    temp_hash[:class] =  "hilite" if session[:sort_by] == header_name
    temp_hash
  end
end
