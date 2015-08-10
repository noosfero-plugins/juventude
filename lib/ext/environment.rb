require_dependency 'environment'

class Environment

  alias_method :orig_custom_person_fields, :custom_person_fields

  def custom_person_fields
    orig_custom_person_fields.merge!({'orientacao_sexual' => {"active"=>"true", "required"=>"false", "signup"=>"true"}})
    orig_custom_person_fields.merge!({'identidade_genero' => {"active"=>"true", "required"=>"false", "signup"=>"true"}})
    orig_custom_person_fields.merge!({'transgenero' => {"active"=>"true", "required"=>"false", "signup"=>"true"}})
    orig_custom_person_fields.merge!({'etnia' => {"active"=>"true", "required"=>"false", "signup"=>"true"}})
    orig_custom_person_fields.merge!({'city' => {"active"=>"true", "required"=>"false", "signup"=>"true"}})
    orig_custom_person_fields
  end

end
