# encoding: UTF-8
class JuventudePlugin::FollowersJob < JuventudePlugin::ReportJob

  def perform
    profile = Profile.find(profile_id)
    report_folder = JuventudePlugin::ReportJob.create_report_path(profile, report_path)
    create_followers_report(profile, report_folder)
  end

  def create_followers_report(profile, report_folder)
    proposals = ProposalsDiscussionPlugin::Proposal.all
    filepath = "/tmp/#{report_path}/followers.csv"
    CSV.open(filepath, 'w', {:col_sep => ';', :force_quotes => true} ) do |csv|
      csv << ['Id Artigo Seguido','Id Pessoa que segue','Data']
      proposals.map do |proposal|
        count = 0
        amount_proposal_followers = proposal.article_followers.count
        proposal.article_followers.map do |article_follower|
          count += 1
          puts "%s de %s: adicionando follower da proposta: %s" % [count, amount_proposal_followers, proposal.id ]
          info = []
 => ArticleFollower(id: integer, person_id: integer, article_id: integer, since: datetime, created_at: datetime, updated_at: datetime) 

          info.push(article_follower.article_id)
          info.push(article_follower.person.identifier)
          info.push(article_follower.created_at.strftime("%d/%m/%y %H:%M"))
          csv << info
        end
      end
    end
    upload_file(compress_files('followers', 'followers.csv'), profile, report_folder)
  end

end
