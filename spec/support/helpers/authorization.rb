# frozen_string_literal: true

module Helpers
  module Authorization
    def sign_in(email, password)
      get :create, params: {
        session: {
          email: email,
          password: password
        }
      }
    end
  end
end
