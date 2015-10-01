require_dependency 'article'

class Article

  has_many :states, :through => :article_categorizations, :source => :category, :class_name => State
  has_many :cities, :through => :article_categorizations, :source => :category, :class_name => City

  settings_items :free_conference

  attr_accessible :free_conference

	scope :conference_articles, joins(:profile).where("profiles.identifier = 'conferencia'")

end
