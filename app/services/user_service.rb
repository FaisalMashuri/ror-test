class UserService
    def initialize(repo = UserRepository.new)
        @repo = repo
    end
    
    def allUser
        @repo.all
    end

    def login(username, password)
        user = @repo.find_by_user_name(username)  # Ensure you fetch the user from the repository
        puts "userr : ", user
        if user && user.authenticate(password)  # Authenticate using the user object
            return user
        else
            return nil
        end
    end
end