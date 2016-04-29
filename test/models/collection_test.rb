# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  hashtag    :string
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  next_url   :string
#

require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
