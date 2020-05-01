class TopNewsD1::Stories
    # model
    
    attr_accessor :title, :description, :topic, :author, :timestamp, :url
    @@today = []

    def initialize
        @@today.push self
    end

    def self.today
        @@today
    end
end
