class ContactController < ApplicationController

  def index
  end

  def create_suggest
    Suggestion.create(username: params["username"], suggest: params["suggest"])
    redirect_to '/contact/index'
  end

end
