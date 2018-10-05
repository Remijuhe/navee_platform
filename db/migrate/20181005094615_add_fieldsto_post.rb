class AddFieldstoPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :nb_posts_user, :integer
    add_column :posts, :reposting_history, :string
    add_column :posts, :market_price, :string
    add_column :posts, :studapart_price, :string
    add_column :posts, :labels, :string
    add_column :posts, :syntax_checking, :string
    add_column :posts, :languages_detected, :string
    add_column :posts, :description_suspiciousness, :integer
    add_column :posts, :pictures_informations, :string
    add_column :posts, :input_errors, :string
    add_column :posts, :email_detected, :boolean
    add_column :posts, :url_detected, :boolean
    add_column :posts, :phone_detected, :boolean
  end
end
