class EpisodeContributor < ApplicationRecord
  belongs_to :episode
  belongs_to :contributor
end
