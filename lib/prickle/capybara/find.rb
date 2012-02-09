module Prickle
  module Actions
    module Find

      def find_by_name type='*', name
        find_element_by_identifier type, { :name => name }
      end

      def method_missing method, *args
        if method =~ /^find_(.*)_by_name$/
          find_by_name $1, args.first
        else
          super
        end
      end

      private
      def find_by_identifier_xpath element, identifier
        "//#{type_of(element)}[#{matcher(identifier)}]"
      end

      def find_element_by_identifier element, identifier
        find_element_by(find_by_identifier_xpath(element, identifier ))
      end

    end
  end
end
