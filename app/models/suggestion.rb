class Suggestion < ApplicationRecord

  before_validation :free_suggests?, :on => :create
  validates :suggest, uniqueness: true
  validates :suggest, :username, presence: true

  private

  def free_suggests?
    Suggestion.where('created_at > ? ', Time.now - 1.hour).count < 100
  end
end
