class PostsController < ApplicationController
    # Ensures that the user is authenticated before accessing any actions in the PostsController.
    before_action :authenticate_user!, except: [:index]


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
        @members = User.all
    end

    private

    def post_params
        params.require(:post).permit(:message)
    end
end
