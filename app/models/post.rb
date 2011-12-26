class Post < ActiveRecord::Base

  acts_as_taggable #标签

  validates_numericality_of  :category
  validates :category,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 2 }
 has_many :comments, :dependent => :destroy
 has_many :tags
  belongs_to:user
 accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
