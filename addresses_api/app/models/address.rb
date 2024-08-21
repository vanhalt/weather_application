class Address < ApplicationRecord
  validates :detail, :postal_code, presence: true

  # This method takes advantage of the `pg_trgm` extension to find similarities in text.
  # The ary is ordered from the top similar DESC
  def self.similar_addresses_to(address)
    find_by_sql ["
        SELECT
          *, similarity(detail, :a) AS sml
        FROM addresses
        WHERE detail % :a
        ORDER BY detail <-> :a
        LIMIT 10",
      {a: address}
    ]
  end

  def self.create_from_validator_data(data)
    postal_address = data[:address][:postalAddress]

    Address.create!(
      region_code: postal_address[:regionCode],
      administrative_area: postal_address[:administrativeArea],
      locality: postal_address[:locality],
      postal_code: postal_address[:postalCode],
      detail: data[:address][:formattedAddress],
      latitude: data[:geocode][:location][:latitude],
      longitude: data[:geocode][:location][:longitude],
    )
  end
end
