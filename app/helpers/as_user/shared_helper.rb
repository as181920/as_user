module AsUser
  module SharedHelper
    def span_vertical_line
      raw "<span class='line'>|</span>"
    end

    def space_filter(n)
      raw "&nbsp;"*n
    end

    def link_main_app
      link_to 'Home', main_app.root_path
    end

    def link_home
      link_to 'Asuser_Home', root_path
    end
  end
end
