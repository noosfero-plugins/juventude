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

end
