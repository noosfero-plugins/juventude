require File.join(Rails.root,'lib','noosfero','api','entities')

module Noosfero
  module API
    module Entities

      class Person < Profile
        expose :orientacao_sexual, :identidade_genero, :transgenero, :etnia
      end

    end
  end
end
