class Summary < ApplicationRecord
  has_many :summary_details, dependent: :destroy

  enum status: [:not_completed, :completed]

  scope :recent, ->{order created_at: :desc}
end
