class User < ApplicationRecord

  # Active_record associations

  has_one_attached :photo

  has_one :farmer, dependent: :destroy
  has_many :messages

  ####

  # Validate custom parameters (or fields) for user
  validates :role, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true
  validates :sex, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Define the scope for all users, except current user
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }
  after_update_commit { broadcast_update }

  # Set default avatar after validate a registration when an user signs up or updates his profile without giving an image field in the file_field for the profile picture in the new or edit forms
  after_commit :add_default_photo, on: %i[create update]

  # Enum the statuses of users : offline, away or online
  enum status: %i[offline away online]

  #Specify the default profile picture in the user's space
  def photo_thumbnail
    if photo.attached?
      photo.variant(resize: "150x150!") # We have to use photo.variant(resize: "150x150!").processed if redis server run well
    else
      "/default_photo.png"
    end
  end

  # Specify the default profile picture in the chat's spaces
  def chat_room_photo
    if photo.attached?
      photo.variant(resize: "50x50!") # We have to use photo.variant(resize: "50x50!").processed if redis server run well
    else
      "/default_photo.png"
    end
  end

  # Define broadcast_update for user's status
  def broadcast_update
    broadcast_replace_to 'user_status', partial: 'users/status', user: self
  end

  # Define status color for differents states
  def status_to_css
    case status
    when 'online'
      'bg-success'
    when 'away'
      'bg-warning'
    when 'offline'
      'bg-dark'
    else
      'bg-dark'
    end
  end

  private

  # Define the default profile picture
  def add_default_photo

    unless photo.attached?
      photo.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_photo.png'
          )
        ),
        filename: 'default_photo.png',
        content_type: 'image/png'
      )
    end

  end

end
