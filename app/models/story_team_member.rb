class StoryTeamMember < ActiveRecord::Base
  include CurrentUser

  attr_protected :user_id
  belongs_to :user
  belongs_to :story

  validates_presence_of :user_id, :story_id

  validates_uniqueness_of :story_id, :scope => :user_id,
    :message => 'is already assigned to you'

  def validate
    if story && !user.organisations.include?(story.project.organisation)
      errors.add(:story, "must belong to one of your projects")
    end
  end
end
