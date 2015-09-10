# encoding: UTF-8
class JuventudePlugin::CommentsJob < JuventudePlugin::ReportJob

  def perform
    profile = Profile.find(profile_id)
    report_folder = JuventudePlugin::ReportJob.create_report_path(profile, report_path)
    create_comments_report(profile, report_folder)
  end

  def create_comments_report(profile, report_folder)
    proposals = ProposalsDiscussionPlugin::Proposal.all
    filepath = "/tmp/#{report_path}/comments.csv"
    CSV.open(filepath, 'w', {:col_sep => ';', :force_quotes => true} ) do |csv|
      csv << ['Id Comentário','Id Proposta','Data', 'Título', 'Conteúdo','Link']
      proposals.map do |proposal|
        count = 0
        amount_proposal_comments = proposal.comments.count
        proposal.comments.map do |comment|
          count += 1
          puts "%s de %s: adicionando comentario da proposta: %s" % [count, amount_proposal_comments, proposal.id ]
          info = []
          info.push(comment.id)
          info.push(proposal.id)
          info.push(comment.created_at.strftime("%d/%m/%y %H:%M"))
          info.push(comment.title)
          info.push(comment.body)
          info.push("http://juventude.gov.br/#{proposal.profile.identifier}/#{proposal.path}#comment-#{comment.id}")
          csv << info
        end
      end
    end
    upload_file(compress_files('comments', 'comments.csv'), profile, report_folder)
  end

end
