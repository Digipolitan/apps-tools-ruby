require 'ui'
require 'file_utils'

module Digipolitan

  class Xcodeproj

    def self.rename_project(project = nil, plist_path = nil)
      if project == nil
        project = self.get_project()
      end

      project_name = File.basename(project, ".xcodeproj")
      app_name = Digipolitan::UI.input("Project name ?")

      if UI.confirm("Are you sure to update the current project to '#{app_name}' ?")
        UI.message("Starting replacement...")
        FileUtils.rename_files(project_name, app_name)
        FileUtils.replace_contents_of_files(project_name, app_name)
        UI.message("Successfully replace '#{project_name}' with '#{app_name}'")
      end
    end

    def self.get_project()
      return Dir['*.xcodeproj'].first
    end

    def self.get_info_plist(project)
      plist_name = "Info.plist"
      if File.exists?(plist_name)
        return plist_name
      else
        return File.join(File.basename(project, ".xcodeproj"), plist_name)
      end
    end

  end
end
