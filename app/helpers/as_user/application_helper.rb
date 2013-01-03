module AsUser
  module ApplicationHelper
    def space_filter(n)
      raw "&nbsp;"*n
    end
    
    def link_main_app
      link_to 'Main_Home', main_app.root_path
    end
    def link_home
      link_to 'Home', root_path
    end
  end
end
