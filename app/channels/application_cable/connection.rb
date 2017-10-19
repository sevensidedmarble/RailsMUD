module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    def connect
      self.current_user = find_verified_user
    end

    # A note on authentication of the telnet clients
    # Right now their user information is being passed unencrypted as params. Obviously this isn't a long term
    # solution. Long term, I think the telnet server will need access to the db so that it can authenticate users on its own before passing the information to actioncable. Or maybe theres a simpler solution.

    private
    def find_verified_user
      if (email = request.params['email']) && (password = request.params['password'])
        puts 'Attempting to verify telnet user.'
        user = User.find_by_email(email)
        if user && user.authenticate(password)
          puts 'Telnet client authentication success!'
          user # is verified
        else
          puts 'Telnet client auth failed.'
          reject_unauthorized_connection
        end
      else
        if verified_user = User.find_by(id: cookies.encrypted[:user_id])
          verified_user
        else
          reject_unauthorized_connection
        end
      end
    end

    # def authorize
    #   redirect_to login_url, alert: "Not authorized" if current_user.nil?
    # end
  end
end
