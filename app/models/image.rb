class Image < ActiveRecord::Base

  attr_accessible :snapshot_id, :snapshot_type, :photo
  has_attached_file :photo, :styles => { :small => '100x100>', :very_small => '50x50>'}
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/jpg'], :message => "Only jpeg, jpg and png files are allowed for pictures"
  # validates_file_format_of :photo, :in => ["gif", "jpg"], :message => "Hey, Upload only GIF and JPG format"
  #Snapshot association
  belongs_to :snapshot, :polymorphic => true
end
