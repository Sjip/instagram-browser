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

require 'test_helper'

class InstagramContentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
