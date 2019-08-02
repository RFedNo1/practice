class LikesController < ApplicationController
    def create
        if @current_user
            if !Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
                like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
                like.save
            end
            if request.referer&.include?("/posts/index")
                redirect_to("/posts/index")
            else
                redirect_to("/posts/#{params[:post_id]}")
            end
        else
            flash[:notice] = "いいね！をするにはログインが必要です"
            redirect_to("/login_form")
        end
    end

    def destroy
        like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
        like.destroy
        if request.referer&.include?("/posts/index")
            redirect_to("/posts/index")
        else
            redirect_to("/posts/#{like.post_id}")
        end
    end

end
