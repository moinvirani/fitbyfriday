class InvitationsController < ApplicationController
  # create load workout before filter
  def index
  end

  def show
    @workout = Workout.find(params[:workout_id])
    @invitation = Invitation.find(params[:id])
    if (@invitation.sender != current_user) && (@invitation.target != current_user)
      redirect_to workouts_path
    end
  end

  def accept
    @invitation = Invitation.find(params[:id])
    @workout = Workout.find(params[:workout_id])
    current_user.workouts << @workout
    @invitation.confirmed = "true"
    @invitation.save
    redirect_to workouts_path
  end

  def decline
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    # Send email or text to sender to notify them that
    redirect_to workouts_path
  end
end
