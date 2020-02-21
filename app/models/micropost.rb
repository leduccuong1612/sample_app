class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content picture).freeze

  belongs_to :user
  delegate :name, to: :user
  has_one_attached :image

  scope :order_desc, ->{order created_at: :desc}
  scope :not_admin, ->{joins(:user).merge(User.not_admin)}

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.validate.content_length}
  validates :image, content_type: {in: Settings.validate.type,
    message: Settings.validate.must_image},
    size: {less_than: Settings.limit.megabyte.megabytes,
    message: Settings.validate.small_pic}

  def display_image
    image.variant resize_to_limit: [Settings.limit.variant, Settings.limit.variant]
  end
end
