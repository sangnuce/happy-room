class User < ApplicationRecord
  has_many :purchases, dependent: :destroy

  def amount_purchased_in_month month
    purchases.in_month(month).reduce(0){|sum, item| sum + item.amount}
  end
end
