class Post < ApplicationRecord
  before_save :default_values
  def default_values
    self.status = 'not validated' if self.status.nil?
  end
  include PgSearch
  pg_search_scope :search_by_city_and_status,
    against: [ :city, :status, :pictures ],
    using: {
      tsearch: { prefix: true }
    }
end
