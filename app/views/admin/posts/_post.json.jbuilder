json.extract! post, :id, :user_id, :title, :content, :cover, :excerpt, :description, :keywords, :status, :published_at, :created_at, :updated_at
json.url post_url(post, format: :json)
json.content post.content.to_s
json.cover url_for(post.cover)
