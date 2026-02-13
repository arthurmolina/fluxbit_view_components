# frozen_string_literal: true

require "digest/md5"

module Fluxbit
  # Standalone Gravatar URL generator.
  #
  # Can be used independently of the component:
  #
  #   Fluxbit::Gravatar.url(email: "user@example.com")
  #   Fluxbit::Gravatar.url(email: "user@example.com", size: :lg, rating: :g)
  #
  # Or via the helper in views:
  #
  #   fx_gravatar_url(email: "user@example.com")
  #
  # From:
  # https://github.com/chrislloyd/gravtastic/blob/master/lib/gravtastic.rb
  # https://chrislloyd.github.io/gravtastic/
  module Gravatar
    ABBREVIATIONS = {
      size: "s",
      default: "d",
      rating: "r",
      forcedefault: "f"
    }.freeze

    class << self
      # Generates a Gravatar URL for the given email.
      #
      # @param email [String] The email address.
      # @param rating [Symbol] Gravatar rating (:g, :pg, :r, :x).
      # @param secure [Boolean] Use HTTPS (default: true).
      # @param filetype [Symbol] Image format (:png, :jpg, :gif, etc.).
      # @param default [Symbol] Default image style (:identicon, :robohash, :mp, etc.).
      # @param size [Symbol, Integer] Size as a symbol (:xs, :sm, :md, :lg, :xl) or pixel integer.
      # @param name [String] Optional name param appended to URL.
      # @param initials [String] Optional initials param appended to URL.
      # @return [String] The full Gravatar URL.
      def url(email:, rating: nil, secure: true, filetype: nil, default: nil, size: nil, name: nil, initials: nil)
        styles = config.gravatar_styles

        rating   = resolve_option(rating,   collection: styles[:rating],   fallback: config.rating)
        filetype = resolve_option(filetype, collection: styles[:filetype], fallback: config.filetype)
        default  = resolve_option(default,  collection: styles[:default],  fallback: config.default)
        size_px  = resolve_size(size, styles[:size])

        params = { rating: rating, default: default, size: size_px }
        params[:name] = name if name.present?
        params[:initials] = initials if initials.present?

        hostname(secure) + filename(email, filetype) + "?" + to_query(process_options(params))
      end

      # Returns the MD5 hash of the email, which Gravatar uses as identifier.
      #
      # @param email [String]
      # @return [String]
      def gravatar_id(email)
        Digest::MD5.hexdigest(email.to_s.downcase)
      end

      private

      def config
        Fluxbit::Config::GravatarComponent
      end

      def resolve_option(value, collection:, fallback:)
        return fallback if value.nil?

        value = value.to_sym if value.respond_to?(:to_sym)
        value.in?(collection) ? value : fallback
      end

      def resolve_size(value, sizes)
        return sizes[:md] if value.nil?
        return value if value.is_a?(Integer)

        key = value.to_sym
        sizes[key] || sizes[:md]
      end

      def hostname(secure)
        "http#{secure ? 's://secure.' : '://'}gravatar.com/avatar/"
      end

      def filename(email, filetype)
        "#{gravatar_id(email)}.#{filetype}"
      end

      def process_options(options)
        options.each_with_object({}) do |(key, val), result|
          case key
          when :forcedefault
            result[key] = "y" if val
          when :name, :initials
            result[key] = val if val.present?
          else
            result[key] = val
          end
        end
      end

      def to_query(hash)
        hash.map { |key, val| "#{ABBREVIATIONS[key.to_sym] || key}=#{val}" }.sort.join("&")
      end
    end
  end
end
