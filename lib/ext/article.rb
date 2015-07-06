require_dependency 'article'

class Article

  has_many :states, :through => :article_categorizations, :source => :category, :class_name => State
  has_many :cities, :through => :article_categorizations, :source => :category, :class_name => City

end
