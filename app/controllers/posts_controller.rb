class PostsController < ApplicationController
  def index
    if params[:query].present?
      @posts = Post.search_by_city_and_status(params[:query])
    else
      @posts = Post.all
    end
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])

    # Price analysis, graph size
    @post_graph_height = @post.rent_with_expenses_amount.round * 0.15
    @market_price_height_lower = eval(@post.market_price)["lower"].round * 0.15
    @market_price_height_mean = eval(@post.market_price)["mean"].round * 0.15
    @market_price_height_higher = eval(@post.market_price)["higher"].round * 0.15
    @studapart_price_height_lower = eval(@post.studapart_price)["lower"].round * 0.15
    @studapart_price_height_mean = eval(@post.studapart_price)["mean"].round * 0.15
    @studapart_price_height_higher = eval(@post.studapart_price)["higher"].round * 0.15

    #Description analysis, syntax checking
    @description_array = []
    previous_number = 0
    if !(eval(@post["syntax_checking"]) == [])
      eval(@post["syntax_checking"]).each do |error|
        @description_array << ["no_error", previous_number, error["from"] - previous_number]
        @description_array << [error["error_message"], error["from"], error["to"] - error["from"]]
        previous_number = error["to"]
      end
      @description_array << ["no_error", previous_number, @post.description.length]
    else
      @description_array << ["no_error", 0, @post.description.length]
    end
  end

  def edit
    @post = Post.find(params[:id])
    # Scrapping Studapart
    a = Mechanize.new
    page = a.get('https://cas.escpeurope.eu/cas/login?service=https%3A%2F%2Fhousing.escpeurope.eu%2Ffr%2Flogin%2Fcas')
    form = page.forms.first
    username_field = form.field_with(:name => "username")
    username_field.value = "e140186"
    password_field = form.field_with(:name => "password")
    password_field.value = "ficelle.1"
    page = form.submit
    page = a.get(@post.link)
    page.search('#translateDescriptionContainer').each do |element|
      @description = element.text.strip
    end
    page.search('#property-conditions > div:nth-child(2) > div:nth-child(1) > span.text-details').each do |element|
      @price = element.text.strip
    end
    page.search('#property-details > div:nth-child(3) > div:nth-child(1) > span.text-details').each do |element|
      @surface = element.text.strip
    end
    page.search('#property-description > div > div.small-12.medium-6.columns.nopaddingcolumns.text-wrapper > div.small-11.columns.p-b-5.nopaddingcolumns.m-t-20.description-line > a > span').each do |element|
      @address = element.text.strip
    end
    page.search('#property-owner > div.row > div.small-12.p-mobile-20.medium-6.p-l-5.columns > a > div > div.small-7.end.columns.nopaddingcolumns > span').each do |element|
      @name = element.text.strip
    end
    @pictures_array = []
    page.search('#gallery-1').each do |element|
      @pictures_array << element.attribute('href').value
    end
    page.search('#property-photos > div.row > div > div.three-image.div-2.small-12.p-mobile-0.div-image-3.medium-4.columns.nopadding > div.small-12.columns.div-image-3-2 > a').each do |element|
      @pictures_array << element.attribute('href').value
    end
    page.search('#property-photos > div.row > div > div.three-image.div-2.small-12.p-mobile-0.div-image-3.medium-4.columns.nopadding > div.three-image.small-12.m-t-15.div-image-3.margin-3-image.columns.div-image-3-3 > a').each do |element|
      @pictures_array << element.attribute('href').value
    end

  studapart_post = {
    "status": "not verified",
    "firstname": "#{@name}",
    "address": @address,
    "rent_with_expenses_amount": @price.to_i,
    "rooms_count": 0,
    "pictures": @pictures_array,
    "zip_code": @address[0...-6].split(//).last(5).join.to_i,
    "lastname": "",
    "property_id": "",
    "coordinates": "",
    "property_surface": @surface.to_i,
    "city": "",
    "description": "#{@description}",
    "user_id": ""
  }
  status = Timeout::timeout(10000) {
  uri = URI("http://localhost:5000/analyze_post")
  http = Net::HTTP.new(uri.host, uri.port)
  req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
  req.body = studapart_post.to_json
  res = http.request(req)
  @response = JSON.parse(res.body)
  }
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to edit_post_path(@post.id)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  private

  def post_params
    params.require(:post).permit([:status, :city, :rent_with_expenses_amount, :user_id, :description, :firstname, :lastname, :property_surface, :coordinates, :address, :pictures, :rooms_count, :zip_code, :link, :nb_posts_user, :reposting_history, :market_price, :studapart_price, :labels, :syntax_checking, :languages_detected, :description_suspiciousness, :pictures_informations, :input_errors, :email_detected, :url_detected, :phone_detected])
  end
end
