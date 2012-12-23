module AsUser
  module ApplicationHelper
    def space_filter(n)
      raw "&nbsp;"*n
    end
    
    def home_link
      link_to 'Home', root_path
    end
  end
end
