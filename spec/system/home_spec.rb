require "rails_helper"

RSpec.describe "Home", type: :system do
  before do
    episode = Episode.create!(identifier: "episode1",
                              title: "面白い話",
                              description: "おもしろい話の説明",
                              position: 1,
                              published_at: Time.zone.now)
    episode.contributors.create!(name: "foobar")
    episode.show_notes.create!(text: "詳細", url: "example.com", position: 1)

    episode = Episode.create!(identifier: "episode2",
                              title: "つまらない話",
                              description: "つまらない話の説明",
                              position: 2,
                              published_at: Time.zone.now)
    episode.contributors.create!(name: "つまらん")
    episode.show_notes.create!(text: "ざっくり", url: "example.net", position: 1)

    visit root_url
  end

  it "list episodes" do
    expect(page).to have_content "面白い話"
    expect(page).to have_content "つまらない話"
  end

  it "search episode with contributor" do
    all("input")[0].set("foo")
    expect(page).to have_content "面白い話"
    expect(page).not_to have_content "つまらない話"
  end

  it "search episode with description" do
    all("input")[1].set("詳細")
    expect(page).to have_content "面白い話"
    expect(page).not_to have_content "つまらない話"
  end
end
