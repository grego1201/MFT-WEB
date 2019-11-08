# frozen_string_literal: true

class ContactController < ApplicationController
  def index
    @free_suggests = 100 - Suggestion.where('created_at > ? ', Time.now - 1.hour).count
  end

  def create_suggest
    suggestion = Suggestion.new(username: params['username'], suggest: params['suggest'])
    if suggestion.save
      flash[:success] = 'Se ha podido crear'
      redirect_to '/show_suggests/index'
    else
      flash[:error] = 'no se ha podido crear'
      redirect_to '/contact/index'
    end
  end
end
