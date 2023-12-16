class PostsController < ApplicationController
    before_action :require_login, only: [:new, :create]


    # Ensures that the user is authenticated before accessing any actions in the PostsController.
    before_action :authenticate_user!


    def new
        @post = Post.new
    end

    def create
        # Associates the new post with the currently signed-in user 
        @post = current_user.posts.build(post_params)

        if @post.save
            redirect_to posts_path, notice: "Post was succesfully created"
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
