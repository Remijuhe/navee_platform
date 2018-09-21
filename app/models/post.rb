class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_city_and_status,
    against: [ :city, :status ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
