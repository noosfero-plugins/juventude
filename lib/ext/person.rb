require_dependency 'person'

class Person

  settings_items :orientacao_sexual, :identidade_genero, :transgenero, :tipo, :etnia

  attr_accessible :orientacao_sexual, :identidade_genero, :transgenero, :tipo, :etnia

end
