class UserPurchase < ApplicationRecord
  belongs_to :user
  belongs_to :purchase

  scope :in_month, ->(month) {
    where(purchase_id: Purchase.in_month(month).select(:id))
  }
end
