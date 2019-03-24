class SummaryServices::CreateSummary
  def perform
    purchases = Purchase.after_last_summary
    total_user_purchases = UserPurchase.where(purchase_id: purchases.select(:id)).group(:user_id).sum(:amount)
    total_user_spent = purchases.group(:user_id).sum(:amount)
    remaining = {}
    (total_user_purchases.keys | total_user_spent.keys).each do |user_id|
      remaining[user_id] = (total_user_spent[user_id] || 0) - (total_user_purchases[user_id] || 0)
    end
    return [false, "Không có khoản chi mới"] if remaining.empty?
    ActiveRecord::Base.transaction do
      summary = Summary.create!
      remaining.each do |user_id, amount|
        summary.summary_details.create! user_id: user_id, amount: amount
      end
    end
    [true]
  rescue
    [false]
  end
end
