# frozen_string_literal: true

class Fluxbit::Components::GravatarComponentPreview < ViewComponent::Preview
  # Fluxbit::GravatarComponent
  # ------------------------
  # You can use this component to display Gravatar avatars with various customization options
  #
  # @param email text "Email address"
  # @param rating select "Rating" :rating_options
  # @param secure [Boolean] toggle "Secure URL?"
  # @param filetype select "Filetype" :filetype_options
  # @param default select "Default" :default_options
  # @param color select "Color" :color_options
  # @param rounded [Boolean] toggle "Rounded?"
  # @param status select "Status" :status_options
  # @param status_position select "Status Position" :status_position_options
  # @param size select "Size" :size_options
  def playground(email: "user@example.com",
                 rating: :pg,
                 secure: true,
                 filetype: :png,
                 default: :robohash,
                 color: "",
                 rounded: true,
                 status: "",
                 status_position: :top_right,
                 size: :md)
    render Fluxbit::GravatarComponent.new(
      email: email,
      rating: rating,
      secure: secure,
      filetype: filetype,
      default: default,
      color: color == "" ? nil : color,
      rounded: rounded,
      status: status == "" ? false : status.to_sym,
      status_position: status_position.to_sym,
      size: size.to_sym
    )
  end

  def default_gravatars; end
  def rating_levels; end
  def file_types; end
  def default_fallbacks; end
  def gravatar_sizes; end
  def with_status; end
  def with_borders; end
  def square_gravatars; end
  def secure_urls; end
  def adding_removing_classes; end
  def adding_other_properties; end

  private

  def rating_options
    Fluxbit::Config::GravatarComponent.gravatar_styles[:rating]
  end

  def filetype_options
    Fluxbit::Config::GravatarComponent.gravatar_styles[:filetype]
  end

  def default_options
    Fluxbit::Config::GravatarComponent.gravatar_styles[:default]
  end

  def color_options
    [ "" ] + Fluxbit::Config::AvatarComponent.styles[:color].keys
  end

  def status_options
    [ "" ] + Fluxbit::Config::AvatarComponent.styles[:status][:options].keys
  end

  def status_position_options
    elements = Fluxbit::Config::AvatarComponent.styles[:rounded][:status_position]
    elements = elements
      .keys
      .each_slice(elements.size / 2)
      .to_a

    elements[0].map { |x| elements[1].map { |y| :"#{x}_#{y}" } }.flatten
  end

  def size_options
    Fluxbit::Config::AvatarComponent.styles[:size].keys
  end
end
