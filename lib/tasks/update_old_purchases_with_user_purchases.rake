namespace :db do
  task update_old_purchases_with_user_purchases: :environment do
    Purchase.where.not(id: UserPurchase.select(:purchase_id)).update user_ids: User.ids
  end
end
