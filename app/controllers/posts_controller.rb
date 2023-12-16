class PostsController < ApplicationController
    before_action :require_login only: [:new, :create]


    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)

        if @post.save
            redirect_to new_post_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def index
        @posts = Post.all
    end

    private

    def require_login
      if current_user.logged_in?
      # allow the user to perform the action they wanted
      else
        redirect_to login_path
      end
    end

    def post_params
        params.require(:post).permit(:message)
    end
end
