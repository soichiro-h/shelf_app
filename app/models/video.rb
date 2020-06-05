# frozen_string_literal: true

class Video < ApplicationRecord
  belongs_to :book, optional: true
  # belongs_to :video_relation, dependent: :destroy, optional: true
  # has_many :relations, class_name: "VideoRelation", foreign_key: "book_id", dependent: :destroy
end
