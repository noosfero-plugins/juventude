require 'csv'
class JuventudePlugin::ReportJob < Struct.new(:profile_id, :report_path)

  include ActionDispatch::TestProcess

  def self.create_report_path(profile, report_path)
    root_report_folder = profile.folders.where(:slug => 'relatorios').first
    root_report_folder ||= Folder.create!(:profile => profile, :name => 'Relatorios')
    FileUtils.mkdir_p "/tmp/#{report_path}"
    report_folder = Folder.find_by_slug(report_path)
    report_folder ||= Folder.create!(:profile => profile, :name => report_path, :parent => root_report_folder)
  end

  def upload_file(filepath, profile, report_folder)
    UploadedFile.create!(:uploaded_data => fixture_file_upload(filepath, 'text/csv'), :profile => profile, :parent => report_folder)
  end

  def compress_files(filename, pattern)
    filepath = "/tmp/#{report_path}/#{filename}.zip"
    system("cd /tmp/#{report_path} && zip #{filepath} #{pattern}")
    filepath
  end

  def perform
    profile = Profile.find(profile_id)
    report_folder = JuventudePlugin::ReportJob.create_report_path(profile, report_path)
    create_proposals_report(profile, report_folder)
  end

  def create_proposals_report(profile, report_folder)
    filepath = "/tmp/#{report_path}/propostas.csv"

    CSV.open(filepath, 'w', {:col_sep => ';', :force_quotes => true} ) do |csv|
      proposals = ProposalsDiscussionPlugin::Proposal.all
      count = 0
      csv << ['Identificador','Criada em', 'Autor', 'Eixo', 'Titulo', 'Proposta', 'Comentarios', 'Seguidores', 'Votos', 'Cidade']
      proposals.map do |proposal|
        count += 1
        puts "%s de %s: adicionando proposta: %s" % [count, proposals.count, proposal.id ]
        info = []
        info.push(proposal.id)
        info.push(proposal.created_at.strftime("%d/%m/%y %H:%M"))
        info.push(proposal.author ? proposal.author.identifier : '')
        info.push(proposal.topic.name)
        info.push(proposal.title)
        info.push(proposal.abstract.present? ? proposal.abstract.gsub(/\s+/, ' ').strip : '')
        info.push(proposal.comments.count)
        info.push(proposal.person_followers.count)
        info.push(proposal.votes_for)
        info.push(proposal.cities.map{|c|c.path}.join(','))
        csv << info
      end
    end
    upload_file(filepath, profile, report_folder)
  end

end
