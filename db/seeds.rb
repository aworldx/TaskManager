User.create(email: 'admin@example.com', password: '123456',
            password_confirmation: '123456', role: :admin)
User.create(email: 'user@example.com', password: '123456',
            password_confirmation: '123456', role: :user)
