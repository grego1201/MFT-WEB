class ShowSuggestsController < ApplicationController

  def index
    @suggestions = Suggestion.all
    @free_suggests = 100 - Suggestion.where('created_at > ? ', Time.now - 1.hour).count
  end

end
