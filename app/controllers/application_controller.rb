require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do
    def self.current_user(session_hash)
      @user = User.find_by(id: session_hash[:user_id])
      @user
    end
    
    def self.is_logged_in?(session_hash)
      !!self.current_user(session_hash)
    end
  end

end