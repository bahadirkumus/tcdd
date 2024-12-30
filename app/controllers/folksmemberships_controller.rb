class FolkMembershipsController < ApplicationController
  def create
    @folk = Folk.find(params[:folk_id])
    @folk.folk_memberships.create(user: current_user, role: :member)
    redirect_to @folk, notice: "You joined the group."
  end

  def destroy
    @membership = FolkMembership.find(params[:id])
    @membership.destroy
    redirect_to folks_path, notice: "You left the group."
  end
end
