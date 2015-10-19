require_dependency 'user'

class User

  def orientacao_sexual
    self.person.orientacao_sexual unless self.person.nil?
  end

  def orientacao_sexual= value
    self.person_data[:orientacao_sexual] = value
  end

  def identidade_genero
    self.person.identidade_genero unless self.person.nil?
  end

  def identidade_genero= value
    self.person_data[:identidade_genero] = value
  end

  def transgenero
    self.person.transgenero unless self.person.nil?
  end

  def transgenero= value
    self.person_data[:transgenero] = value
  end

  def tipo
    self.person.tipo unless self.person.nil?
  end

  def tipo= value
    self.person_data[:tipo] = value
  end

  def etnia
    self.person.etnia unless self.person.nil?
  end

  def etnia= value
    self.person_data[:etnia] = value
  end

  def city= city
    city = City.find(city) unless city.kind_of?(City)
    self.person_data[:region] = city
  end

  def category_ids= categories
    self.person_data[:category_ids] = categories
  end

  def membro_conselho
    self.person.membro_conselho unless self.person.nil?
  end

  def membro_conselho= value
    self.person_data[:membro_conselho] = value
  end

end
