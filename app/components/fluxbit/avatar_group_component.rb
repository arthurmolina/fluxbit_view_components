# frozen_string_literal: true

# The `Fluxbit::AvatarGroupComponent` is a component for rendering a group of avatars.
# It extends `Fluxbit::Component` and provides options for configuring the appearance
# and behavior of the avatar group. You can control the avatars and gravatars displayed
# within the group. The component supports rendering multiple avatars and gravatars,
# each of which can be styled or customized through various properties.
class Fluxbit::AvatarGroupComponent < Fluxbit::Component
  include Fluxbit::Config::AvatarComponent
  renders_many :avatars, Fluxbit::AvatarComponent
  renders_many :gravatars, Fluxbit::GravatarComponent

  def call
    tag.div(class: styles[:group]) do
      avatars.each do |avatar|
        concat render(avatar)
      end
      gravatars.each do |gravatar|
        concat render(gravatar)
      end
    end
  end
end
