class CollectionsController < ApplicationController
  def show
  end

  def create
    @collection = Collection.create(collections_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def collections_params
    params.require(:collection).permit(
      :end_date,
      :hashtag,
      :start_date)
  end
end