require "pony"

module Actions

  class Actions::UnsafeBranchCommit < Actions::Base
    
    UNSAFE_BRANCHES = ["master", "releases"]
    PEOPLE_TO_NOTIFY = ["redwave@gmail.com"]
    
    def perform!
      if UNSAFE_BRANCHES.include?(@package.branch)
=begin
        Pony.mail(:to => 'you@example.com', :via => :smtp, :via_options => {
            :address        => 'smtp.yourserver.com',
            :port           => '25',
            :user_name      => 'user',
            :password       => 'password',
            :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
            :domain         => "localhost.localdomain" # the HELO domain provided by the client to the server
          }
=end        

        commiter = "#{@package.commit["author"]["name"]} <#{@package.commit["author"]["email"]}>"
        body = "#{commiter} pushed to unsafe branch \"#{@package.branch}\": #{@package.commit["url"]}"
        subject = "Commit(s) to unsafe branch happened"
        from = "Robot <robot@example.com>"
        PEOPLE_TO_NOTIFY.push(commiter)
        
        PEOPLE_TO_NOTIFY.each do |address|
          Pony.mail(:to => address, :from => from, :subject => subject, :body => body, :via => :sendmail)
        end
        
        self.result = body
      end
    end
    
  end

end