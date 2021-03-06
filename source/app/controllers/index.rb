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
  @user = User.find(session[:user_id])
  @tweet = Tweet.all
  erb :home
end



post '/tweet' do
  user = User.find(session[:user_id])
  Tweet.create(content: params[:content], user: user)
  redirect "/home"
end

get '/tweet' do
  erb :tweet

end


post '/signin' do
  @user = User.find_by(username: params[:username])

  if @user.password == params[:password]
    session[:user_id] = @user.id

    redirect "/"
  else
    @route_origin = "Incorrect Login. Please try again."
    redirect "/"
  end
end

get '/sign_up' do
  @route_origin = "Sign Up Here"
  erb :index
end

post '/sign_up' do

  @user = User.create(username: params[:username])
  p @user
  @user.password = params[:password]

  @user.save!
  p "*****************"
  p @user
  p "*****************"
  session[:user_id] = @user.id
  redirect "/"

end

get '/logged_in' do

end

post '/logout' do
  session.clear
  redirect "/"
end


delete '/user_tweet/delete/:id' do
  Tweet.find(params[:id]).destroy
  redirect "/"
end


#todo: test session sepparate file?
