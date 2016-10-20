Shortener::ShortenedUrl.class_eval do
  def meta
    JSON.parse(super)
  rescue
    nil
  end

  def meta=(value)
    super(value.to_json)
  end

  class << self

    def apply_scopes(scope, destination_url, meta: nil)
      scopes = scope.where(url: clean_url(destination_url))

      if Shortener.enable_meta && meta
        scopes = scopes.where(meta: meta.to_json)
      end

      scopes
    end
  end
end
