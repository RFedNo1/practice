class ApplicationController < ActionController::Base

    before_action :set_login_user

    def set_login_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def logined_user?
        if @current_user == nil
            flash[:notice] = "ログインが必要です"
            redirect_to("/login_form")
        end
    end

    def forbid_login_user
        if @current_user
            flash[:notice] = "すでにログインしています"
            redirect_to("/posts/index")
        end
    end

end
