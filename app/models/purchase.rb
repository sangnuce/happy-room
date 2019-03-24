class Purchase < ApplicationRecord
  belongs_to :user
  has_many :user_purchases, dependent: :destroy
  has_many :users, through: :user_purchases

  scope :recent, ->{order date: :desc, created_at: :desc}
  scope :in_month, ->month do
    date = month ? "01/#{month}".to_date : Time.zone.today
    where "date >= ? AND date <= ?", date.beginning_of_month, date.end_of_month
  end
  scope :after_last_summary, -> {
    last_summary = Summary.last
    return unless last_summary
    where("created_at > ?", last_summary.created_at)
  }

  after_save :update_user_purchase_amount

  private

  def update_user_purchase_amount
    user_purchases.update_all amount: (amount / user_purchases.size)
  end
end
