class EpisodesController < ApplicationController
  # caches_action :index
  before_action { request.format = :json }

  def index
    episodes = Episode.includes(:show_notes, :contributors).
                 order(:position).limit(params[:limit])
    render json: episodes.as_json(
      methods: %i[contributor_text show_note_full_text],
      include: :show_notes,
    )
  end
end
