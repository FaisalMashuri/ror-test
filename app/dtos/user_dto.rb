class UserDto
    attr_reader :id, :name
    def initialize(user)
        @id = user.id
        @name = user.username
    end
end