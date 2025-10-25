# frozen_string_literal: true

# From:
# https://github.com/chrislloyd/gravtastic/blob/master/lib/gravtastic.rb
# https://chrislloyd.github.io/gravtastic/

require "digest/md5"

# The `Fluxbit::GravatarComponent` is a component for rendering Gravatar avatars.
# It extends `Fluxbit::AvatarComponent` and provides options for configuring the
# Gravatar's appearance and behavior. You can control the Gravatar's rating, size,
# filetype, and other attributes. The Gravatar URL is constructed based on the
# provided email address and options.
class Fluxbit::GravatarComponent < Fluxbit::AvatarComponent
  include Fluxbit::Config::AvatarComponent
  include Fluxbit::Config::GravatarComponent

  # Initializes the Gravatar component with the given properties.
  #
  # @param [Hash] props The properties to customize the Gravatar.
  # @option props [String] :email The email address associated with the Gravatar.
  # @option props [Symbol] :rating (:g) The rating of the Gravatar (:g, :pg, :r, :x).
  # @option props [Boolean] :secure (true) Whether to use HTTPS for the Gravatar URL.
  # @option props [Symbol] :filetype (:png) The filetype of the Gravatar (:png, :jpg, :gif).
  # @option props [Symbol] :default (:identicon) The default image to use if no Gravatar is found.
  # @option props [Integer] :size (:md) The size of the Gravatar base on the size provided by AvatarComponent.
  # @option props [Boolean] :url_only (false) If true, returns only the Gravatar URL instead of rendering the avatar component.
  # @option props [String] :remove_class ('') Classes to be removed from the default Gravatar class list.
  # @option props [Hash] **props Remaining options declared as HTML attributes, applied to the Gravatar container.
  def initialize(**props)
    @props = props
    @gravatar_options = {
      rating: options((@props.delete(:rating)|| "").to_sym, collection: gravatar_styles[:rating], default: @@rating),
      secure: options(@props.delete(:secure), default: true),
      filetype: options((@props.delete(:filetype)|| "").to_sym, collection: gravatar_styles[:filetype], default: @@filetype),
      default: options((@props.delete(:default)|| "").to_sym, collection: gravatar_styles[:default], default: @@default),
      size: gravatar_styles[:size][options(@props[:size], collection: gravatar_styles[:size], default: @@size)]
    }
    add class: gravatar_styles[:base], to: @props
    @email = @props.delete(:email)
    @url_only = @props.delete(:url_only)
    src = gravatar_url
    super(src: src, **@props)
  end

  def call
    return gravatar_url.html_safe if @url_only
    super
  end

  # The raw MD5 hash of the users' email. Gravatar is particularly tricky as
  # it downcases all emails. This is really the guts of the module,
  # everything else is just convenience.
  def gravatar_id
    Digest::MD5.hexdigest(@email.to_s.downcase)
  end

  # Constructs the full Gravatar url.
  def gravatar_url
    gravatar_hostname(@gravatar_options.delete(:secure)) +
      gravatar_filename(@gravatar_options.delete(:filetype)) +
      "?#{url_params_from_hash(process_options(@gravatar_options))}"
  end

  # Creates a params hash like "?foo=bar" from a hash like {'foo' => 'bar'}.
  # The values are sorted so it produces deterministic output (and can
  # therefore be tested easily).
  def url_params_from_hash(hash)
    hash.map do |key, val|
      [ gravatar_abbreviations[key.to_sym] || key.to_s, val.to_s ].join("=")
    end.sort.join("&")
  end

  # Returns either Gravatar's secure hostname or not.
  def gravatar_hostname(secure)
    "http#{secure ? 's://secure.' : '://'}gravatar.com/avatar/"
  end

  # Munges the ID and the filetype into one. Like "abc123.png"
  def gravatar_filename(filetype)
    "#{gravatar_id}.#{filetype}"
  end

  # Some options need to be processed before becoming URL params
  def process_options(options_to)
    processed_options = {}
    options_to.each do |key, val|
      case key
      when :forcedefault
        processed_options[key] = "y" if val
      else
        processed_options[key] = val
      end
    end
    processed_options
  end

  def gravatar_abbreviations
    {
      size:         "s",
      default:      "d",
      rating:       "r",
      forcedefault: "f"
    }
  end
end
