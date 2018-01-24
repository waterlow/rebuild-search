require 'open-uri'

class Crawler < ApplicationJob
  after_perform { Rails.cache.clear }

  def perform
    contributor_names = Mechanize.new
      .get('http://rebuild.fm/people')
      .search('span.name').map { |e| [e.text] }

    [ShowNote, EpisodeContributor, Contributor, Episode].each(&:delete_all)

    Contributor.import([:name], contributor_names)

    contributors = Contributor.pluck(:name, :id).to_h
    aliases = Contributor.pluck(:name).map { |name| [name, []] }.to_h

    hash = Hash.from_xml(open('http://feeds.rebuild.fm/rebuildfm'))
    items = hash['rss']['channel']['item']

    episodes = []
    show_notes = []
    episode_contributors = []

    items.each.with_index(1) do |item, id|
      html = Nokogiri::HTML.parse(item['description'])
      description = html.children.children.children.children.first.text

      identifier = item['link'][/\d+a?/]
      episode = Episode.new(id:           id,
                            identifier:   identifier,
                            title:        item['title'],
                            description:  description,
                            position:     id,
                            published_at: Time.zone.parse(item['pubDate']))
      episodes << episode

      e_position = 1
      html.search('li a').each do |elm|
        show_notes << episode.show_notes.new(text: elm.children.text,
                                             url:  elm.attributes['href'].value,
                                             position: e_position)
        e_position += 1
      end

      items = Array.wrap(item['contributor'])
      items.each do |c|
        episode_contributors << episode.episode_contributors.new(contributor_id: contributors[c['name']])
      end

      next if items.size > 2 || episode.contributor_alias.blank?

      aliases[items.first['name']] << episode.contributor_alias.strip
      aliases[items.first['name']].uniq!
    end

    Episode.import(episodes, validate: false)
    ShowNote.import(show_notes, validate: false)
    EpisodeContributor.import(episode_contributors, validate: false)

    Contributor.all.each do |c|
      c.update!(name: "#{c.name},#{aliases[c.name].join(',')}") if aliases[c.name].present?
    end
  end
end
