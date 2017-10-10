module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      if id = request.headers['id']
        # TODO add password verification here!
        if verified_user = User.find_by(id: request.headers['id'])
          verified_user
        else
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
