class Profile < ActiveRecord::Base
   belongs_to :user

  validates_numericality_of(:birth_year,:only_integer => true,:greater_than => 1963, :less_than => 2012 ,:allow_blank => true ,:message => '1963-2011')
  validates_numericality_of(:birth_month,:only_integer => true,:greater_than =>0,:less_than =>13 ,:allow_blank => true ,:message => '1-12')
  validates_presence_of :birth_year, :birth_month, :birth_day,:on => :update      #不能为空验证
  validates_numericality_of :birth_year,:birth_month,:birth_day ,:allow_blank => true   #不能为非数字验证

end
