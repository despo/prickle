module Prickle
  module Capybara

    TAGS = { :link => 'a' }

    def find_by_name name
      find(:xpath, "//*[@name='#{name}']")
    end

    def click_by_name name
      find_by_name(name).click
    end

    def method_missing method, *args
      if method =~ /^find_(.*)_by_name$/
        element = TAGS[$1.to_sym] || $1
        find(:xpath, "//#{element}[@name='#{args.first}']")
      elsif method =~ /^click_(.*)_by_name$/
        element = TAGS[$1.to_sym] || $1
        find(:xpath, "//#{element}[@name='#{args.first}']").click
      else
        super
      end
    end

  end
end
