class Image < ActiveRecord::Base

  attr_accessible :snapshot_id, :snapshot_type, :photo
  has_attached_file :photo, :styles => { :small => '100x100>' }

  #Snapshot association
  belongs_to :snapshot, :polymorphic => true
end
