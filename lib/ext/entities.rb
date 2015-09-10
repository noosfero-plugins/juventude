module Noosfero
  module API
    module Entities

      class Person < Profile
        expose :orientacao_sexual, :identidade_genero, :transgenero, :etnia
      end

    end
  end
end
