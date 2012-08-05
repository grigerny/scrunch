class Provider < ActiveRecord::Base
  attr_accessible :street, :bio, :city, :insured, :name, :phone, :service_id, :state, :website, :zip, :latitude, :longitude
  
  geocoded_by :address 
    after_validation :geocode
    
    def address
       [street, city, state].compact.join(', ')
     end
     
  acts_as_gmappable :check_process => false, :process_geocoding => false
  def gmaps4rails_title
        'You found me!'
      end
  

  
  belongs_to :service
  belongs_to :user
  has_many :comments
  has_reputation :votes, source: :user, aggregated_by: :sum
  
  
  
  validates :name, :presence => true
  validates :insured, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
  validates :phone, :presence => true
  validates :website, :presence => true
  validates :service_id, :presence => true
  validates :bio, :presence => true
  validates_length_of :bio, :maximum => 140
end
