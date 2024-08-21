class EnableExtension < ActiveRecord::Migration[7.2]
  def change
    execute 'CREATE EXTENSION pg_trgm;'
  end
end
