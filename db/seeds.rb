require 'json'

p "Destroy all posts"

Post.destroy_all

p "Generating all posts"

filepath = 'db/flagged_studapart_posts.json'
serialized_studapart_posts = File.read(filepath)
studapart_posts = JSON.parse(serialized_studapart_posts)
studapart_posts.each do |studapart_post|
  post = Post.new(status: studapart_post[1]['status'], city: studapart_post[1]['city'], rent_with_expenses_amount: studapart_post[1]['rent_with_expenses_amount'], user_id: studapart_post[1]['user_id'], description: studapart_post[1]['description'], firstname: studapart_post[1]['firstname'], lastname: studapart_post[1]['lastname'], property_surface: studapart_post[1]['property_surface'], coordinates: studapart_post[1]['coordinates'], address: studapart_post[1]['address'], pictures: studapart_post[1]['pictures'], rooms_count: studapart_post[1]['rooms_count'], property_id: studapart_post[1]['property_id'], zip_code: studapart_post[1]['zip_code'])
  post.save
  p "ok"
end

p "Posts generation : success"
