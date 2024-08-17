json.extract! notice, :id, :category, :location, :platform, :first_name, :last_name, :dob, :dod, :nickname, :wording, :relationship, :published_at, :created_at, :updated_at
json.url notice_url(notice, format: :json)
