puts "1. Seeding users"
ActiveRecord::Base.transaction do
  ["Thi", "Tường", "Sáng"].each do |user_name|
    User.create! name: user_name
  end
end