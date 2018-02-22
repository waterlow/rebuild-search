class Episode < ApplicationRecord
  has_many :show_notes, -> { order(:position) }, dependent: :delete_all
  has_many :episode_contributors, dependent: :delete_all
  has_many :contributors, through: :episode_contributors

  def contributor_text
    contributors.map(&:name).join(",")
  end

  def show_note_texts
    @show_note_texts ||= show_notes.map(&:text)
  end

  def show_note_full_text
    show_note_texts.join(",")
  end

  def contributor_alias
    japanese? ? alias_japanese : alias_english
  end

  private

    def japanese?
      self.description =~ /\p{Hiragana}|\p{Katakana}|[一-龠々]/
    end

    def alias_japanese
      return unless (m = self.description.match(/\A([^。]*)(xさんをゲストに|をゲストに|さんと)/))
      m[1].split(/,|、/).map { |s| s.sub(/\s?さん\z/, "") }.join(",")
    end

    def alias_english
      return unless (m = self.description.match(/\A(.*)\sjoins?\sme/))
      m[1].gsub(" and ", ",")
    end
end
