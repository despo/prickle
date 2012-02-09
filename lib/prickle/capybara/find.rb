module Prickle
  module Actions
    module Find

      def find_by_name type='*', name
        wait_until(Prickle::Capybara.wait_time) do
          find(:xpath, "//#{type}[@name='#{name}']").visible?
        end unless Prickle::Capybara.wait_time.nil?

        find(:xpath, "//#{type}[@name='#{name}']")
      end

      def method_missing method, *args
        if method =~ /^find_(.*)_by_name$/
          element = Prickle::TAGS[$1.to_sym] || $1
          find_by_name element, args.first
        else
          super
        end
      end

    end
  end
end
