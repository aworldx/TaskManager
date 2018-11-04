# frozen_string_literal: true

module Helpers
  module Authorization
    def log_in(email, password)
      get :create, params: { session: { email: email, password: password } }
    end

    def sign_in(email, password)
      visit 'login'

      fill_in 'Email', with: email
      fill_in 'Password', with: password

      click_button 'Save Session'
    end
  end
end
