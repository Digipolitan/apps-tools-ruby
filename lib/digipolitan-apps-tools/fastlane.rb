require 'fastlane'

module Digipolitan

  class Fastlane

    def self.init()
      app_identifier = nil
      if FastlaneCore::UI.confirm("Would you like to update your app_identifier")
        app_identifier = FastlaneCore::UI.input("App identifier ?")
        Digipolitan::Fastlane.update_app_identifier(app_identifier)
      end
      apple_id = nil
      team_name = nil
      if FastlaneCore::UI.confirm("Init fastlane ?")
        if app_identifier == nil
          app_identifier = FastlaneCore::UI.input("App identifier ?")
        end
        apple_id = FastlaneCore::UI.input("Apple ID ?")
        team_name = FastlaneCore::UI.input("Team name ?")
        Digipolitan::Fastlane.app_init(app_identifier, apple_id, team_name)
        if FastlaneCore::UI.confirm("Init pilot (Use for beta testing) ?")
          Digipolitan::Fastlane.pilot_init()
        end
        if FastlaneCore::UI.confirm("Init deliver (Use for appstore submission) ?")
          Digipolitan::Fastlane.deviler_init(app_identifier, apple_id)
          Digipolitan::Fastlane.snapshot_init()
        end
      end
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
        FastlaneCore::UI.user_error! ("Error during fastlane 'update_app_identifier'")
      end
    end

    def self.app_init(app_identifier, apple_id, team_name)
      app_file_data = ""
      if app_identifier.length() > 0
        app_file_data += "app_identifier \"#{app_identifier}\" # The bundle identifier of your app\n"
      end
      if apple_id.length() > 0
        app_file_data += "apple_id \"#{apple_id}\" # Your Apple email address\n"
      end
      if team_name.length() > 0
        app_file_data += "team_name \"#{team_name}\"\n"
      end
      Digipolitan::FileUtils.write_to_file("fastlane/Appfile", app_file_data)
    end

    def self.deviler_init(app_identifier, apple_id)
      deliver_file_data = "app_identifier \"#{app_identifier}\" # The bundle identifier of your app\nusername \"#{apple_id}\" # Your Apple email address"
      Digipolitan::FileUtils.write_to_file("fastlane/Deliverfile", deliver_file_data)
      age_ratings = {
        "CARTOON_FANTASY_VIOLENCE" => 0,
        "REALISTIC_VIOLENCE" => 0,
        "PROLONGED_GRAPHIC_SADISTIC_REALISTIC_VIOLENCE" => 0,
        "PROFANITY_CRUDE_HUMOR" => 0,
        "MATURE_SUGGESTIVE" => 0,
        "HORROR" => 0,
        "MEDICAL_TREATMENT_INFO" => 0,
        "ALCOHOL_TOBACCO_DRUGS" => 0,
        "GAMBLING" => 0,
        "SEXUAL_CONTENT_NUDITY" => 0,
        "GRAPHIC_SEXUAL_CONTENT_NUDITY" => 0,
        "UNRESTRICTED_WEB_ACCESS" => 0,
        "GAMBLING_CONTESTS" => 0
      }
      if FastlaneCore::UI.confirm("Is your app have age rating ?")
        ratings = ["none", "minor", "major"]
        loop do
          age_ratings.each { |key, value|
            FastlaneCore::UI.message("#{key} => #{value}")
          }
          key = FastlaneCore::UI.input("What rating key would you like to update ?")
          if age_ratings.key?(key)
            value = FastlaneCore::UI.select("Choose a rating value", ratings)
            if i = ratings.index(value)
              age_ratings[key] = i
            end
          end
          break if !FastlaneCore::UI.confirm("Would you like to update another key ?")
        end
      end
      print age_ratings.to_json
    end

    def self.pilot_init()
    end

    def self.snapshot_init()
    end

  end
end
