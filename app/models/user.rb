class User
  # concerns
  include Mongoid::Document
  include Mongoid::Timestamps
  include Exceptional
  include Identification
  include Authenticatable
  include Buildable

  # fields
  field :name, type: String
  field :email, type: String
  field :password_hash, type: String
  field :password_recovery, type: String
  field :session_expires_in, type: DateTime

  # relations
  has_many :topics
  has_many :comments

  # validations
  validates :name, :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :email
  validate :password_presence

end