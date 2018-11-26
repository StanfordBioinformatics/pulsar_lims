module DataStoragesHelper
  DNANEXUS_URL = "https://platform.dnanexus.com/"

  def url_to_dnanexus_project(project_id)
    url = "#{DNANEXUS_URL}projects/#{project_id.split("project-")[-1]}"
    return url
  end
end
