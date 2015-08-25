class Comment
  # concerns
  include Mongoid::Document
  include Mongoid::Timestamps
  include Exceptional
  include Buildable

  # fields
  field :body,      type: String
  field :user_id,   type: BSON::ObjectId
  field :topic_id,  type: BSON::ObjectId
  field :parent_id, type: BSON::ObjectId

  # relations
  belongs_to :topic
  belongs_to :user
  belongs_to :parent, class_name: "Comment", inverse_of: :childrens
  has_many :childrens, class_name: "Comment", inverse_of: :parent

  # validations
  validates :body, :user_id, :topic_id, presence: true
end