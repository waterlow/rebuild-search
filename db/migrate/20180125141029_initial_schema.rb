class InitialSchema < ActiveRecord::Migration[5.1]
  def change
    create_table :contributors, force: :cascade do |t|
      t.string :name, null: false
      t.timestamps

      t.index [:name], unique: true
    end

    create_table :episode_contributors, force: :cascade do |t|
      t.integer :episode_id, null: false
      t.integer :contributor_id, null: false
      t.timestamps

      t.index [:contributor_id]
      t.index [:episode_id]
    end

    create_table :episodes, force: :cascade do |t|
      t.string :identifier, null: false
      t.string :title, null: false
      t.string :description, null: false
      t.integer :position, null: false
      t.datetime :published_at, null: false
      t.timestamps

      t.index [:identifier], unique: true
      t.index [:position], unique: true
    end

    create_table :show_notes, force: :cascade do |t|
      t.integer :episode_id, null: false
      t.string :text, null: false
      t.text :url, null: false
      t.integer :position, null: false
      t.timestamps

      t.index [:episode_id]
      t.index [:id, :position], unique: true
      t.index [:position]
    end

    add_foreign_key :episode_contributors, :contributors
    add_foreign_key :episode_contributors, :episodes
    add_foreign_key :show_notes, :episodes
  end
end
