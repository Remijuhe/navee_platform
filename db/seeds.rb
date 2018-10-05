require 'json'
require 'timeout'

p "Destroy all posts..."

Post.destroy_all

p "Cleaning database: success"

p "Generating all posts..."

uri = URI("http://localhost:5000/analyze_post")
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})

filepath = 'db/flagged_studapart_posts.json'
serialized_studapart_posts = File.read(filepath)
studapart_posts = JSON.parse(serialized_studapart_posts)
studapart_posts.each do |studapart_post|
  status = Timeout::timeout(10000) {
    if [2637, 11584, 4859, 8192, 7107, 10292, 9212, 14084, 2830, 2657, 2176, 4517, 10499, 7812, 21921, 50, 11149].include?(studapart_post[1]["id"])
    req.body = studapart_post[1].to_json
    res = http.request(req)
    response = JSON.parse(res.body)
    post = Post.new(status: "Scam", city: studapart_post[1]['city'], rent_with_expenses_amount: studapart_post[1]['rent_with_expenses_amount'], user_id: studapart_post[1]['user_id'], description: studapart_post[1]['description'], firstname: studapart_post[1]['firstname'], lastname: studapart_post[1]['lastname'], property_surface: studapart_post[1]['property_surface'], coordinates: studapart_post[1]['coordinates'], address: studapart_post[1]['address'], pictures: studapart_post[1]['pictures'], rooms_count: studapart_post[1]['rooms_count'], property_id: studapart_post[1]['property_id'], zip_code: studapart_post[1]['zip_code'], nb_posts_user: response["nb_posts_user"], reposting_history: response["reposting_history"], market_price: response["market_price"], studapart_price: response["studapart_price"], labels: response["labels"], syntax_checking: response["syntax_checking"], languages_detected: response["languages_detected"], description_suspiciousness: response["lexical_scammer_score"], pictures_informations: response["pictures_informations"], input_errors: response["input_errors"], email_detected: response["email_detected"], url_detected: response["url_detected"], phone_detected: response["phone_detected"])
    post.save
    p "ok"
    p studapart_post
    end
  }
end

p "Posts generation : success"
