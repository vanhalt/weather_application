class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :region_code
      t.string :administrative_area
      t.string :locality
      t.string :postal_code
      t.string :detail
      t.string :latitude
      t.string :longitude

      t.timestamps
    end

    execute 'CREATE INDEX addresses_detail_trgm_idx ON addresses USING GIST (detail gist_trgm_ops);'
  end
end
