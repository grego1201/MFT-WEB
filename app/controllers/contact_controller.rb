class ContactController < ApplicationController

  def index
    @free_suggests = 100 - Suggestion.where('created_at > ? ', Time.now - 1.hour).count
  end

  def create_suggest
    Suggestion.create(username: params["username"], suggest: params["suggest"])
    redirect_to '/contact/index'
  end

end
