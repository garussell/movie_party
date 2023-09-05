# frozen_string_literal: true

class CreateWatchParties < ActiveRecord::Migration[7.0]
  def change
    create_table :watch_parties do |t|
      t.string :host
      t.string :movie
      t.integer :duration
      t.date :date
      t.datetime :time

      t.timestamps
    end
  end
end
