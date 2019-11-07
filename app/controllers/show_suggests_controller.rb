class ShowSuggestsController < ApplicationController

  def index
    @suggestions = Suggestion.all
    @free_suggests = 100 - Suggestion.where('created_at > ? ', Time.now - 1.hour).count
  end

  def create_suggest
    suggestion = Suggestion.new(username: params["username"], suggest: params["suggest"])

    if suggestion.save
      flash[:success] = "Se ha podido crear"
    else
      flash[:error] = "no se ha podido crear"
    end

    redirect_path = '/show_suggests/index' + '?locale=' + take_referrer_locale
    redirect_to redirect_path
  end

  private

  def take_referrer_locale
    parsed_locale = request.referrer.split('/').fourth
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : I18n.default_locale.to_s
  end
end
