class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    #render json: request.env['omniauth.auth']
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'VK')
    end
  end
end