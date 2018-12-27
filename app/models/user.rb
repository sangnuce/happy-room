class User < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :user_purchases, dependent: :destroy

  def amount_purchased_in_month month
    purchases.in_month(month).sum(:amount)
  end

  def all_amount_in_month month
    user_purchases.in_month(month).sum(:amount)
  end
end
