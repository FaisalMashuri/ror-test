class BaseDto
    attr_reader :status, :message, :data

    def initialize(status:, message:, data: nil)
        @status = status
        @message = message
        @data = data
    end

    def as_json(options = {})
        {
            status: @status,
            message: @message,
            data: @data
        }
    end
end

