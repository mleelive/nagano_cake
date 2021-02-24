class Public::HomesController < ApplicationController
  def top
    @active_items = Item.where(is_active: true).limit(4).order("created_at DESC")
  end

  def about
  end

end
