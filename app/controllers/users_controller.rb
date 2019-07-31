class UsersController < ApplicationController
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
        @user = User.new(name: params[:user][:name], email: params[:user][:email], image_name: "default_user.png")
        if @user.save
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
end
