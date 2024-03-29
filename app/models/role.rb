class Role < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify

  def to_s
    return self.name
  end
end
