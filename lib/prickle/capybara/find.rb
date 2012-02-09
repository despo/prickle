module Prickle
  module Actions
    module Find

      def find_by_name type='*', name
        find_element_by_name type, name
      end

      def method_missing method, *args
        if method =~ /^find_(.*)_by_name$/
          find_element_by_name $1, args.first
        else
          super
        end
      end

      private
      def find_by_name_xpath element, name
        "//#{type_for(element)}[@name='#{name}']"
      end

      def find_element_by_name element, name
        find_element_by(find_by_name_xpath(element, name))
      end

    end
  end
end
