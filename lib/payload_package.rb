class PayloadPackage
  attr_accessor :branch, :commit, :url
  
  def initialize(branch = nil, commit = nil, url = nil)
    @branch = branch unless branch == nil
    @commit = commit unless commit == nil
    @url = url unless url == nil
  end

end