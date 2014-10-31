get '/' do
  # Look in app/views/index.erb
  if session[:user_id]
    #@route_origin = "You've logged in! your user id is: #{session[:user_id]}"
    redirect "/home"
  else
    erb :index

  end
end

get '/home' do
  # erb :home
  @tweets = Tweets.find_by[:id]
end



post '/tweet' do
  user_id = session[:user_id]
  Tweet.create(content: params[:content], user: params[user_id])
  redirect "/home"
end



post '/signin' do
  @user = User.find_by(username: params[:username])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    @route_origin = "You've logged in! your user id is: #{@user.id}"
    redirect "/"
  else
    @route_origin = "Incorrect Login. Please try again."
    erb :index
  end
end

get '/sign_up' do
  @route_origin = "Sign Up Here"
  erb :index
end

post '/sign_up' do
  @route_origin = "You're signed up (to be fixed later)"
  @user = User.create(params)
  erb :index
end

get '/logged_in' do

end

get '/logout' do
  session.clear
  redirect "/"
end



#todo: test session sepparate file?
