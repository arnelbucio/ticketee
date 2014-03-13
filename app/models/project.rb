class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :tickets, dependent: :delete_all
  has_many :permissions, as: :thing

  scope :for, -> (user) do
    user.admin? ? Project.all : Project.viewable_by(user)
  end
  scope :viewable_by, -> (user) do
    joins(:permissions).where(permissions: { action: "view",
                                             user_id: user.id })
  end
  scope :admins, -> { where(admin: true) }
  scope :by_name, -> { order(:name) }
end
