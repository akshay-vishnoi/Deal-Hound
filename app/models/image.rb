class Image < ActiveRecord::Base

  attr_accessible :snapshot_id, :snapshot_type, :photo
  paperclip_s3_storage_options = {
    :styles => { :small => '100x100>', :very_small => '50x50>'}, 
    :default_url => "calender/no_image.png", 
    :storage => :s3,
    :s3_credentials => 'config/s3.yml',
    :s3_host_name => S3[:HOST_NAME][Rails.env], 
    :bucket => S3[:S3_BUCKET_NAME][Rails.env], 
    :path => "products/:attachment/:id/:style.:extension"    
  }

  has_attached_file :photo, paperclip_s3_storage_options

  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/jpg'], :message => "Only jpeg, jpg and png files are allowed for pictures"
  # validates_file_format_of :photo, :in => ["gif", "jpg"], :message => "Hey, Upload only GIF and JPG format"
  #Snapshot association
  belongs_to :snapshot, :polymorphic => true
end
