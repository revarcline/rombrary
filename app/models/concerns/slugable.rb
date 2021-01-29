module Slugifiable
  module InstanceMethods
    def slug
      name.downcase.gsub(/[^a-z0-9\s]/, '').gsub(' ', '-')
    end
  end

  module ClassMethods
    def find_by_slug(slug_name)
      all.find { |item| item.slug == slug_name }
    end
  end
end
