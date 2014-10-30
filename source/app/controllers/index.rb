get '/' do
  # Look in app/views/index.erb
  if session[:user_id]
    @route_origin = "You've logged in! your user id is: #{session[:user_id]}"
    @signout = "<a href = '/logout'>sign out link?</a>"
    erb :index
  else
    @route_origin = "Welcome! Please log in"
    erb :index
  end
end

post '/' do
  @user = User.find_by(username: params[:username])

  if @user.password_hash == params[:password]
    session[:user_id] = @user.id
    @route_origin = "You've logged in! your user id is: #{@user.id}"

    redirect "/"
  else
    @route_origin = "You're not logged in!"
    erb :index
  end
end

get '/sign_up' do
  @route_origin = "Sign Up Here"
  erb :sign_up
end

post '/sign_up' do
  @route_origin = "You're signed up (to be fixed later)"

  @user = User.create(username: params[:username], password_hash: params[:password],
  email: params[:email])
  erb :index
end

get '/logged_in' do

end

get '/logout' do
  session.clear
  redirect "/"
end



#todo: test session sepparate file?
