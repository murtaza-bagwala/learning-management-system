# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :course

  has_one_attached :video, dependent: :destroy

  validates :title, uniqueness: true, presence: true
  validates :video, blob: { content_type: ['video/mp4', 'video/webm', 'video/x-flv'], size_range: 1..(4.megabytes) }
end
