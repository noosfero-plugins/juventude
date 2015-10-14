require File.join(Rails.root,'lib','noosfero','api','entities')

module Noosfero
  module API
    module Entities

      class Person < Profile
        expose :orientacao_sexual, :identidade_genero, :transgenero, :etnia

        expose :points do |person, options|
          person.points if person.respond_to?(:points) 
        end

        expose :level do |person, options|
          person.level if person.respond_to?(:level) 
        end

        expose :gamification_plugin_level_percent do |person, options|
          person.gamification_plugin_level_percent if person.respond_to?(:gamification_plugin_level_percent) 
        end

      end

    end
  end
end
