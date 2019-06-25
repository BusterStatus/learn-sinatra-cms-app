class UsersController < ApplicationController

    get '/' do
        erb :welcome
    end

    get '/signup' do
        user = User.find_by(id: session[:user_id])
        if !user.nil?
          if user.id == session[:user_id]
            redirect to '/amiibos'
          end
        else
          erb :'/users/signup'
        end
    end

    post '/signup' do
        if params[:email] == "" || params[:password] == "" ||  params[:confirm_password] == ""
            redirect to '/signup'
        else
            user = User.create(email: params[:email], password: params[:password])
            session[:user_id] = user.id
            redirect to '/amiibos'
        end
    end

    get '/login' do
        user = User.find_by(id: session[:user_id])
        if !user.nil?
          if user.id == session[:user_id]
            redirect to '/amiibos'
          end
        else
          erb :'/users/login'
        end
    end
    
    post '/login' do
        user = User.find_by(:email => params[:email])
 
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/amiibos"
        else
          redirect "/login"
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    post '/logout' do
        user = User.find_by(id: session[:user_id])
        if !user.nil?
            session.clear
            redirect to '/login'
        else
          erb :'/users/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @amiibos = Tweet.all
        erb :'/users/show'
    end

end