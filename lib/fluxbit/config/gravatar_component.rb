# frozen_string_literal: true

module Fluxbit::Config::GravatarComponent
  mattr_accessor :rating, default: :pg
  mattr_accessor :filetype, default: :png
  mattr_accessor :default, default: :robohash # options: 404, mp (mystery person), identicon, monsterid, wavatar, retro, robohash, blank

  # rubocop: disable Layout/LineLength, Metrics/BlockLength
  mattr_accessor :gravatar_styles do
    {
      base: "bg-gray-200 dark:bg-gray-600",
      default: %i[404 mp identicon monsterid wavatar retro robohash blank],
      size: { xs: 30, sm: 40, md: 50, lg: 100, xl: 200 },
      rating: %i[g pg r x],
      filetype: %i[jpg jpeg gif png heic]
    }
  end
  # rubocop: enable Layout/LineLength, Metrics/BlockLength
end
