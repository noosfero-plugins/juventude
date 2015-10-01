require_dependency 'person'

class Person

  settings_items :orientacao_sexual, :identidade_genero, :transgenero, :tipo, :etnia

  attr_accessible :orientacao_sexual, :identidade_genero, :transgenero, :tipo, :etnia

  def conference_comments
    Profile['conferencia'].comments_received.where(author_id: id)
  end
end
