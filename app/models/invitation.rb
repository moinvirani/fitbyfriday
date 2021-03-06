class Invitation < ActiveRecord::Base
  belongs_to :workout

  belongs_to :sender, class_name: "User", foreign_key: 'sender_id'
  belongs_to :target, class_name: "User", foreign_key: 'target_id'

  validate :cannot_send_duplicate_invite

  def cannot_send_duplicate_invite
    if Workout.find(workout_id).invitations.any?
      Workout.find(workout_id).invitations.each do |i|
        if i.target_id == target_id
          errors.add(:target_id, "was already invited.")
        end
      end
    end
  end

  def invite_limit
    if Workout.find(workout_id).user_workouts.count > 2 
      errors.add(:workout_id, "is full")
    end
  end

  def cannot_invite_self
    if current_user = self.target
      errors.add(:target_id, "can't invite yourself")
    end
  end
end
