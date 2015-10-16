require_dependency 'person'

class Person

  settings_items :orientacao_sexual, :identidade_genero, :transgenero, :tipo, :etnia

  attr_accessible :orientacao_sexual, :identidade_genero, :transgenero, :tipo, :etnia

  def is_profile_complete?
    #FIXME: this check is hardcoded to satisfy a temporary issue.
    #a better fix is being implemented already
    !(self.name.blank? or
      (self.data[:identidade_genero].blank? and self.data[:transgenero].blank?) or
      self.data[:etnia].blank? or
      self.data[:orientacao_sexual].blank? or
      self.data[:state].blank? or
      self.data[:city].blank?)
  end

  def conference_comments
    Profile['conferencia'].comments_received.where(author_id: id)
  end
end
