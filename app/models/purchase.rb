class Purchase < ApplicationRecord
  belongs_to :user

  scope :recent, ->{order created_at: :desc}
  scope :in_month, ->date do
    where "date >= ? AND date <= ?", date.beginning_of_month, date.end_of_month
  end
end
