require File.join(Rails.root,'lib','noosfero','api','entities')

module Noosfero
  module API
    module Entities

      class Person < Profile
        expose :orientacao_sexual, :identidade_genero, :transgenero, :etnia, :points, :level, :gamification_plugin_level_percent
      end

    end
  end
end
