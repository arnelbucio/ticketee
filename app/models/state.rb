class State < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end

  def default!
    State.find_by(default: true).try(:update!, default: false)

    update!(default: true)
  end
end
