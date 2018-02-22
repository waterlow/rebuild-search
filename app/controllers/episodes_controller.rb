class EpisodesController < ApplicationController
  # caches_action :index
  before_action { request.format = :json }

  def index
    episodes = Episode.eager_load(:show_notes, :contributors).
                 order("episodes.position, show_notes.position")
    render json: episodes.as_json(
      methods: %i[contributor_text show_note_full_text],
      include: :show_notes,
    )
  end
end
