class UserRepository
    def initialize
        @model = User
    end
    
    def all
        @model.all
    end
    
    def find_by_user_name(username)
        @model.find_by(username: username)
      end
end