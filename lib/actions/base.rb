module Actions

  class Actions::Base
    attr_accessor :result
    
    def initialize(package)
      @package = package
    end
    
    def perform!
      raise "Should implement perform! method"
    end
  end

end