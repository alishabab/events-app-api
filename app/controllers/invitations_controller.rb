class InvitationsController < ApplicationController
  
  def create
    @invitation = Invitation.new(invite_params)
    @invitation.attended_event_id = params[:event_id]
    event = Event.find_by(id: params[:event_id])
    user = User.find_by(id: params[:attendee_id])

    event_attendees = event.attendees

    if user.nil?
      render json: {message: 'User does not exist'}
    elsif !event_attendees.include?(user)
      @invitation.save
      render json: @invitation, status: :created
    else
      render json: {message: 'Already invited'}, status: :unprocessable_entity
    end
  end

  def destroy
    @invitation = Invitation.find_by(attended_event_id: params[:event_id],attendee_id: params[:attendee_id]);
    @invitation.destroy
    render json: { message: 'Invitation deleted' }, status: :ok
  end

  def attendees
    event = Event.find_by(id: params[:event_id])
    render json: event.attendees
  end

  private

  def invite_params
    params.permit(:attendee_id)
  end
end
