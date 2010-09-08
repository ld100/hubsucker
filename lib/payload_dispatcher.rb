class PayloadDispatcher
  attr_accessor :branch, :commits, :url

  def initialize(payload)
    @payload = payload
    @branch = @payload["ref"].gsub("refs/heads/", "")
    @url = @payload["repository"]["url"]
    @commits = @payload["commits"]
  end
  
  def dispatch!
    @action_results = []
    @commits.each do |commit|
      package = PayloadPackage.new(@branch, commit, @url)
      #TODO: Here we should programmatically call different actions instead of hardcode
      action = Actions::UnsafeBranchCommit.new(package)
      action.perform!
      @action_results.push(action.result)
    end
    @action_results
  end

end