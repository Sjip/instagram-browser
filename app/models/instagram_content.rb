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
#

class InstagramContent < ActiveRecord::Base
  validates :created_time, :caption_text, :media_url, presence: true
  validates :caption_text, uniqueness: { scope: [:created_time, :media_url] }

  belongs_to :collection
end
