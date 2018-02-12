class InitialSchema < ActiveRecord::Migration[5.1]
  def change
    create_table :contributors, force: :cascade do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps
    end

    create_table :episodes, force: :cascade do |t|
      t.string :identifier, null: false, index: { unique: true }
      t.string :title, null: false
      t.string :description, null: false
      t.integer :position, null: false, index: { unique: true }
      t.datetime :published_at, null: false
      t.timestamps
    end

    create_table :episode_contributors, force: :cascade do |t|
      t.references :episode, null: false, foreign_key: true
      t.references :contributor, null: false, foreign_key: true
      t.timestamps
    end

    create_table :show_notes, force: :cascade do |t|
      t.references :episode, null: false, foreign_key: true
      t.string :text, null: false
      t.text :url, null: false
      t.integer :position, null: false, index: true
      t.timestamps

      t.index [:id, :position], unique: true
    end
  end
end
