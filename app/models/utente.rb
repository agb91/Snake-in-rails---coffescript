class Utente < ActiveRecord::Base
  validates :user, presence: true
  validates :password, presence: true

  before_save :default_values
  def default_values
    self.record1 ||= '0'
    self.record2 ||= '0'
    self.record3 ||= '0'
  end
end
