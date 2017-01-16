class User < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_secure_password

  has_many :lists, dependent: :destroy
  has_and_belongs_to_many :shared_lists, class_name: 'List', dependent: :destroy
  has_many :tasks, through: :lists, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, format: EMAIL_REGEX, uniqueness: true
  validates :password, length: { minimum: 8 }, on: :create

  after_create :create_default_list, :check_pending_lists

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  private

  def create_default_list
    lists.create(title: :default)
  end

  def check_pending_lists
    List.by_pending_email(email).each do |list|
      list.users << self
    end
  end
end
