# frozen_string_literal: true

class Fluxbit::Components::AvatarComponentPreview < ViewComponent::Preview
  # Fluxbit::AvatarComponent
  # ------------------------
  # You can use this component to display a message to the user
  #
  # @param color select "Color" :color_options
  # @param rounded [Boolean] toggle "Rounded?"
  # @param placeholder_initials text
  # @param status select "Status" :status_options
  # @param status_position select "Status" :status_position_options
  # @param size select "Size" :size_options
  # @param src text
  def playground(color: "",
                 rounded: true,
                 placeholder_initials: "",
                 status: "",
                 status_position: :top_right,
                 size: :md,
                 src: "")
    render Fluxbit::AvatarComponent.new(
      color: color == "" ? nil : color,
      rounded: rounded,
      placeholder_initials: placeholder_initials == "" ? false : placeholder_initials,
      status: status == "" ? false : status.to_sym,
      status_position: status_position.to_sym,
      size: size.to_sym,
      src: src == "" ? nil : src
    )
  end

  def with_images; end
  def with_initials; end
  def placeholder_icons; end
  def avatar_sizes; end
  def with_status; end
  def with_borders; end
  def square_avatars; end
  def status_positions; end
  def adding_removing_classes; end
  def adding_other_properties; end

  # Fluxbit::GravatarComponent
  # ------------------------
  # You can use this component to display a message to the user
  #
  # @param rating select "Rating" :rating_options
  # @param secure [Boolean] toggle "Secure URL?"
  # @param filetype select "Filetype" :filetype_options
  # @param default select "Default" :default_options
  # @param color select "Color" :color_options
  # @param rounded [Boolean] toggle "Rounded?"
  # @param status select "Status" :status_options
  # @param status_position select "Status" :status_position_options
  # @param size select "Size" :size_options
  def playground_gravatar(rating: :pg, secure: true, filetype: :png,
                          default: :robohash, color: "", rounded: true,
                          status: "", status_position: :top_right, size: :md)
    render Fluxbit::GravatarComponent.new(
      rating: rating,
      color: color == "" ? nil : color,
      rounded: rounded,
      secure: secure,
      default: default,
      filetype: filetype,
      status: status == "" ? false : status.to_sym,
      status_position: status_position.to_sym,
      size: size.to_sym
    )
  end

  def gravatar_group; end

  private

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

  def rating_options
    Fluxbit::Config::GravatarComponent.gravatar_styles[:rating]
  end

  def filetype_options
    Fluxbit::Config::GravatarComponent.gravatar_styles[:filetype]
  end

  def default_options
    Fluxbit::Config::GravatarComponent.gravatar_styles[:default]
  end
end
