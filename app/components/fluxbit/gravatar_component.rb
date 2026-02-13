# frozen_string_literal: true

# The `Fluxbit::GravatarComponent` is a component for rendering Gravatar avatars.
# It extends `Fluxbit::AvatarComponent` and provides options for configuring the
# Gravatar's appearance and behavior. You can control the Gravatar's rating, size,
# filetype, and other attributes.
#
# The URL generation logic lives in `Fluxbit::Gravatar` and can be used standalone:
#
#   Fluxbit::Gravatar.url(email: "user@example.com")
#
class Fluxbit::GravatarComponent < Fluxbit::AvatarComponent
  include Fluxbit::Config::AvatarComponent
  include Fluxbit::Config::GravatarComponent

  # Initializes the Gravatar component with the given properties.
  #
  # @param [Hash] props The properties to customize the Gravatar.
  # @option props [String] :email The email address associated with the Gravatar.
  # @option props [String] :name The display name for the Gravatar (used with :initials and :color defaults).
  # @option props [String] :initials Custom initials to display (used with :initials default).
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
    @email = @props.delete(:email)
    @url_only = @props.delete(:url_only)

    @gravatar_url_options = {
      rating: @props.delete(:rating),
      secure: @props.delete(:secure),
      filetype: @props.delete(:filetype),
      default: @props.delete(:default),
      size: @props[:size],
      name: @props.delete(:name),
      initials: @props.delete(:initials)
    }.compact

    add class: gravatar_styles[:base], to: @props
    src = Fluxbit::Gravatar.url(email: @email, **@gravatar_url_options)
    super(src: src, **@props)
  end

  def call
    return Fluxbit::Gravatar.url(email: @email, **@gravatar_url_options).html_safe if @url_only
    super
  end
end
