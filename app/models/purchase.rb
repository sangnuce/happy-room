class Purchase < ApplicationRecord
  belongs_to :user

  scope :recent, ->{order date: :desc, created_at: :desc}
  scope :in_month, ->month do
    date = month ? "01/#{month}".to_date : Time.zone.today
    where "date >= ? AND date <= ?", date.beginning_of_month, date.end_of_month
  end
end
