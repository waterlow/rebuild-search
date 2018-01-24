class EpisodesController < ApplicationController
  caches_action :index

  def index
    request.format = :json
    @episodes = Episode.eager_load(:show_notes, :contributors)
      .order('episodes.position, show_notes.position')
  end
end
