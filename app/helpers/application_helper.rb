module ApplicationHelper

	def store_selection
        Store.find(:all).collect{|st| [st.name, st.id]}.unshift([" -- choose store -- ", ""])
      end

      def event_type_selection
        [[" -- choose type -- ", ""],["Monthly", 1],["Ongoing", 2],["Special", 3],["Save The Date", 4]]
      end

      def monthname(monthnumber)
        if monthnumber
          Date::MONTHNAMES[monthnumber]
        end
      end
      
end
