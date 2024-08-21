class ZipCodeCache
  def initialize(zipcode, expires_in = 30.minutes)
    @key = "#{zipcode}/cached_temperature"
    @expires_in = expires_in
  end

  def write(data)
    Rails.cache.write(@key, data, expire_in: @expires_in)
  end

  def read
    Rails.cache.read(@key).merge({from_cache: true})
  end

  def exists?
    Rails.cache.exist?(@key)
  end
end
