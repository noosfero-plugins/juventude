# encoding: UTF-8
class JuventudePlugin::VotesJob < JuventudePlugin::ReportJob

  def perform
    profile = Profile.find(profile_id)
    report_folder = JuventudePlugin::ReportJob.create_report_path(profile, report_path)
    create_votes_report(profile, report_folder)
  end

  def create_votes_report(profile, report_folder)
    proposals = ProposalsDiscussionPlugin::Proposal.all
    filepath = "/tmp/#{report_path}/votes.csv"
    CSV.open(filepath, 'w', {:col_sep => ';', :force_quotes => true} ) do |csv|
      csv << ['Id Artigo Votado','Id Pessoa que votou','Data']
      proposals.map do |proposal|
        count = 0
        amount_proposal_votes = proposal.votes.count
        proposal.votes.map do |vote|
          count += 1
          puts "%s de %s: adicionando voto da proposta: %s" % [count, amount_proposal_votes, proposal.id ]
          info = []
 => ArticleFollower(id: integer, person_id: integer, article_id: integer, since: datetime, created_at: datetime, updated_at: datetime) 

          info.push(vote.voteable_id)
          info.push(vote.voter.identifier)
          info.push(vote.created_at.strftime("%d/%m/%y %H:%M"))
          csv << info
        end
      end
    end
    upload_file(compress_files('votes', 'votes.csv'), profile, report_folder)
  end

end
