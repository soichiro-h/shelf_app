# frozen_string_literal: true

class VideoRelation < ApplicationRecord
  belongs_to :video
  belongs_to :book
end
