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

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    CONFERENCE_RULES = {
      comment_author_conferencia: [
        {
          action: 'comment#create',
          default_threshold: 5,
          to: :author,
          value: lambda { |comment, author| author.present? ? author.conference_comments.count : 0 }
        }
      ],
      comment_received_conferencia: [
        {
          action: 'comment#create',
          default_threshold: 5,
          to: lambda {|comment| comment.source.author},
          value: lambda { |comment, author| author.present? ? Comment.where(source_id: Article.conference_articles.where(author_id: author.id)).count : 0 }
        }
      ],
      article_author_conferencia: [
        {
          action: 'article#create',
          default_threshold: 5,
          to: :author,
          value: lambda { |article, author| author.present? ? TextArticle.conference_articles.where(author_id: author.id).count : 0 }
        },
      ],
      positive_votes_received_conferencia: [
          {
          action: 'vote#create',
          default_threshold: 5,
          to: lambda {|vote| vote.voteable.author},
          value: lambda { |vote, author| vote.voteable.profile.identifier == 'conferencia' ? Vote.for_voteable(vote.voteable).where('vote > 0').count : 0 }
        }
      ],
      negative_votes_received_conferencia: [
        {
          action: 'vote#create',
          default_threshold: 5,
          to: lambda {|vote| vote.voteable.author},
          value: lambda { |vote, author| vote.voteable.profile.identifier == 'conferencia' ? Vote.for_voteable(vote.voteable).where('vote < 0').count : 0 }
        }
      ],
      votes_performed_conferencia: [
        {
          action: 'vote#create',
          default_threshold: 5,
          to: lambda {|vote| vote.voter},
          value: lambda { |vote, voter| vote.voteable.profile.identifier == 'conferencia' ? Vote.for_voter(voter).count : 0}
        }
      ],
      creative_conferencia: [
        {
          action: 'comment#create',
          default_threshold: 5,
          to: :author,
          value: lambda { |comment, author| author.present? ? author.conference_comments.count : 0 }
        },
        {
          action: 'article#create',
          default_threshold: 5,
          to: :author,
          value: lambda { |article, author| author.present? ? TextArticle.conference_articles.where(author_id: author.id).count : 0 }
        },
      ],
      observer_conferencia: [
        {
          action: 'article_follower#create',
          default_threshold: 5,
          to: :person,
          value: lambda { |article, person| person.present? ? person.article_followers.where(article_id: Article.conference_articles).count : 0 }
        }
      ],
      #activist_conferencia: [
        #{
          #action: 'Vote#create',
          #default_threshold: 5,
          #to: lambda { |vote| vote.voter },
          #value: lambda { |vote, voter| vote.voteable.profile.identifier == 'conferencia' ? Vote.for_voter(voter).count : 0 }
        #},
        #{
          #action: 'Event#create',
          #default_threshold: 5,
          #to: lambda { |event| event.author },
          #value: lambda { |event, author| author.events.count }
        #},
      #],
      #mobilizer_conferencia: [
        #{
          #action: 'Vote#create',
          #default_threshold: 5,
          #to: lambda { |vote| vote.voter },
          #value: lambda { |vote, voter| vote.voteable.profile.identifier == 'conferencia' ? Vote.for_voter(voter).count : 0 }
        #},
        #{
          #action: 'Event#create',
          #default_threshold: 5,
          #to: lambda { |event| event.author },
          #value: lambda { |event, author| author.events.count }
        #},
      #],
      generous_conferencia: [
        {
          action: 'vote#create',
          default_threshold: 5,
          to: lambda {|vote| vote.voter},
          value: lambda { |vote, voter| voter.present? ? voter.votes.where('vote > 0').where('voteable_id' => Article.conference_articles, 'voteable_type' => 'Article').count : 0 }
        },
        {
          action: 'comment#create',
          default_threshold: 5,
          to: :author,
          value: lambda { |comment, author| author.present? ? Comment.where(source_id: Article.conference_articles.where(author_id: author.id)).count : 0 }
        }
      ],
      articulator_conferencia: [
        {
          action: 'article_follower#create',
          default_threshold: 5,
          to: :person,
          value: lambda { |article, person| person.present? ? person.article_followers.where(article_id: Article.conference_articles).count : 0 }
        },
        {
          action: 'comment#create',
          default_threshold: 5,
          to: :author,
          value: lambda { |comment, author| author.present? ? Comment.where(source_id: Article.conference_articles.where(author_id: author.id)).count : 0 }
        },
        #mobilizer#create
      ]
    }

  end
end
