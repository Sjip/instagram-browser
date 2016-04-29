# == Schema Information
#
# Table name: instagram_contents
#
#  id            :integer          not null, primary key
#  created_time  :datetime
#  caption_text  :text
#  media_url     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  collection_id :integer
#  media_type    :string
#

class InstagramContent < ActiveRecord::Base
  paginates_per 20

  validates :created_time, :caption_text, :media_url, :media_type, presence: true
  validates :caption_text, uniqueness: { scope: [:created_time, :media_url, :media_type] }
  validates :media_type, inclusion: { in: ['image', 'video'] }

  belongs_to :collection

  def is_image?
    media_type == 'image'
  end

  def is_video?
    media_type == 'video'
  end
end
