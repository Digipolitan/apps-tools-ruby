
module Digipolitan

  class Xcodeproj

    def self.rename_project(project = nil)
      if project == nil
        project = self.get_project()
      end

      project_name = File.basename(project, ".xcodeproj")
      app_name = Digipolitan::UI.input("Project name ?")

      if Digipolitan::UI.confirm("Are you sure to replace the current project '#{project_name}' to '#{app_name}' ?")
        Digipolitan::UI.message("Starting replacement...")
        ignored_entries = [".git", "DerivedData"]
        Digipolitan::FileUtils.rename_files(project_name, app_name, ignored_entries)
        Digipolitan::FileUtils.replace_contents_of_files(project_name, app_name, ignored_entries)

        Digipolitan::FileUtils.replace_contents_of_files(self.build_define(project_name), self.build_define(app_name), ignored_entries)

        Digipolitan::UI.success("Successfully replaced '#{project_name}' with '#{app_name}'")
      end
    end

    def self.get_project()
      return Dir['*.xcodeproj'].first
    end

    def self.build_define(project_name)
      res = project_name.upcase
      res = res.gsub(" ", "_")
      return "_#{res}_H"
    end

    # Visibility
    private_class_method :build_define
  end
end
