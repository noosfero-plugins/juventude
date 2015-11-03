class JuventudePlugin < Noosfero::Plugin

  def self.plugin_name
    _('Juventude custom plugin')
  end

  def self.plugin_description
    _("Provide a plugin to juventude environment.")
  end

  def self.api_mount_points
    [JuventudePlugin::API]
  end

  def control_panel_buttons
    {:title => _('Generate Report'), :icon => 'report', :url => {:controller => 'juventude_plugin_myprofile', :action => :send_report}, :html_options => {:class => 'admin-report'}} if context.send(:current_person).is_admin?

  end

  def stylesheet?
    true
  end
end
