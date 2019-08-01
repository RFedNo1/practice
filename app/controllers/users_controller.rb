class UsersController < ApplicationController

    before_action :logined_user?, only: [:edit, :update]
    before_action :forbid_login_user, only: [:new, :create, :login_form, :login]

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(
            name: params[:user][:name],
            email: params[:user][:email],
            image_name: "default_user.png",
            password: params[:user][:password]
        )
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "ユーザを登録しました"
            redirect_to("/users/index")
        else
            render("users/new")
        end
    end

    def edit
        @user = User.find_by(id: params[:id])
    end

    def update
        @user = User.find_by(id: params[:id])
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        if params[:user][:image]
            @user.image_name = "#{@user.id}.png"
            image = params[:user][:image]
            File.binwrite("public/user_images/#{@user.image_name}", image.read)
        end
        if @user.save
            flash[:notice] = "ユーザ情報を編集しました"
            redirect_to("/users/#{@user.id}")
        else
            render("users/edit")
        end
    end

    def login_form
    end

    def login
        @user = User.find_by(email: params[:email], password: params[:password])
        if @user
            session[:user_id] = @user.id
            flash[:notice] = "ログインしました！"
            redirect_to("/posts/index")
        else
            @error_message = "メールアドレス、もしくはパスワードが間違っています"
            render("users/login_form")
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました！"
        redirect_to("/login_form")
    end
end
