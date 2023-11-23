# frozen_string_literal: true
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorization
  end

  def google_oauth2
    authorization
  end

  private

  def authorization
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted? #ユーザー情報が登録済みのため、新規登録ではなくログイン処理を行う
      sign_in_and_redirect @user, event: :authentication
    else #ユーザー情報が未登録のため、新規登録画面へ遷移する
      render template: 'devise/registrations/new'
    end
  end
end
