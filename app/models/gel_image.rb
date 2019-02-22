class GelImage < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks                                                              
  include ModelConcerns                                                                                
  ABBR = "GELI"                                                                                         
  DEFINITION = "Represents an image of an agarose or polyacrylamide gel used in electrophoresis. Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :gel

  def self.policy_class                                                                                
    ApplicationPolicy                                                                                  
  end 

  def s3_direct_post                                                                                   
    # Used for getting a bucket object URI for uploading a gel image.                                  
    # Called in the controller via a private method with the same name.                                
    return S3_BUCKET.presigned_post(key: "images/gels/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end
end
