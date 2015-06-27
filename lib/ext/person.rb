require_dependency 'person'

class Person

  settings_items :orientacao_sexual, :identidade_genero, :transgenero, :tipo

  attr_accessible :orientacao_sexual, :identidade_genero, :transgenero, :tipo

end
