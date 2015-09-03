require_dependency 'person'

class Person

  settings_items :orientacao_sexual, :identidade_genero, :transgenero, :tipo, :etnia

  attr_accessible :orientacao_sexual, :identidade_genero, :transgenero, :tipo, :etnia

  def city= city
    city = City.find(city) unless city.kind_of?(City)
    self.region = city
  end

  def city
    self.region
  end

  def state
    self.region.parent if self.region
  end

end
