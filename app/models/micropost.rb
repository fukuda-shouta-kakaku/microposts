class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many   :re_micropost
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def can_re_micropost_by?(user)
    return unless user

    !self.re_micropost.pluck(:user_id).include?(user.id) \
      && self.user_id != user.id
  end
end
