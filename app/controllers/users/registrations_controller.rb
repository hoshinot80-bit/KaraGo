class Users::RegistrationsController < Devise::RegistrationsController
  private

  def update_resource(resource, params)
    if params[:email] == resource.email && params[:password].blank?
      resource.update_without_password(params.except(:current_password))
    else
      super
    end
  end
end