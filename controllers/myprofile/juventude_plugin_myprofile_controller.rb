# encoding: UTF-8
class JuventudePluginMyprofileController < MyProfileController

  before_filter :is_admin

  def send_report
    report_path = Time.zone.now.strftime('%Y-%m-%d-%H-%M-%S')
    JuventudePlugin::ReportJob.create_report_path(profile, report_path)
    Delayed::Job.enqueue(JuventudePlugin::ReportJob.new(profile.id, report_path))
    session[:notice] = _("Favor aguardar: o relatório será criado na pasta Relatorios/%s") % report_path
    redirect_to :back
  end

  protected

  def is_admin
    render_access_denied unless current_person.is_admin?
  end


end
