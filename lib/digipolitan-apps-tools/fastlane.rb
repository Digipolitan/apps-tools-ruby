module Digipolitan

  class Fastlane

    def self.init()
      app_identifier = Digipolitan::UI.input("App identifier ?")
      apple_id = Digipolitan::UI.input("Apple ID ?")
      team_name = Digipolitan::UI.input("Team name ?")
      self.update_app_identifier(app_identifier)
      self.app_init(app_identifier, apple_id, team_name)
      self.deliver_init()
      self.snapshot_init()
    end

    def self.update_app_identifier(app_identifier, project = nil, plist_path = nil)
      if project == nil
        project = Digipolitan::Xcodeproj.get_project()
      end

      if plist_path == nil
        plist_path = Digipolitan::Xcodeproj.get_info_plist(project)
      end
      begin
        system("fastlane run update_app_identifier app_identifier:#{app_identifier} plist_path:#{plist_path}")
      rescue
        Digipolitan::UI.error("Error during fastlane 'update_app_identifier'")
      end
    end

    def self.app_init(app_identifier, apple_id, team_name)
      app_file_data = ""
      if app_identifier.length() > 0
        app_file_data += "app_identifier #{app_identifier}\" # The bundle identifier of your app\n"
      end
      if apple_id.length() > 0
        app_file_data += "apple_id \"#{apple_id}\" # Your Apple email address\n"
      end
      if team_name.length() > 0
        app_file_data += "team_name \"#{team_name}\"\n"
      end
      Digipolitan::FileUtils.write_to_file("fastlane/Appfile", app_file_data)
    end

    def self.deviler_init()
    end

    def self.snapshot_init()
    end

  end
end
