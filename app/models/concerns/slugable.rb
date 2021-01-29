module Slugifiable
  def make_slug(name)
    name.downcase.gsub(/[^a-z0-9\s]/, '').gsub(' ', '-')
  end

  def name=(name)
    self.slug = make_slug(name)
    super
  end

  def username=(name)
    self.slug = make_slug(name)
    super
  end
end
