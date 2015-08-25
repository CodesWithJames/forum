class Topic
  # concerns
  include Mongoid::Document
  include Mongoid::Timestamps
  include Exceptional
  include Buildable

  # fields
  field :body, type: String
  field :subject, type: String
  field :user_id, type: BSON::ObjectId

  # relattions
  belongs_to :user
  has_many :comments

  # validations
  validates :subject, :body, :user_id, presence: true


end