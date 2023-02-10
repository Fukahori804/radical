class MoviesController < ApplicationController
    
        before_action :authenticate_user!, only: [:new, :create]
        def index
          if params[:search] != nil && params[:search] != ''
            search = params[:search]
            @movies = Movie.where("name LIKE ? OR directorsname LIKE ?", "%#{search}%", "%#{search}%")
          else
            @movies = Movie.all.page(params[:page]).per(5)

          end
        end
      
        def new
          @movie = Movie.new
        end
      
        def create
          movie = Movie.new(movie_params)
          movie.user_id=current_user.id
          if movie.save
            redirect_to :action => "index"
          else
            redirect_to :action => "new"
          end
        end
      
        def show
          @movie = Movie.find(params[:id])
          @comments = @movie.comments
          @comment = Comment.new
        end
      
        def edit
          @movie = Movie.find(params[:id])
        end
      
        def update
          movie = Movie.find(params[:id])
          if movie.update(movie_params)
            redirect_to :action => "show", :id => movie.id
          else
            redirect_to :action => "new"
          end
        end
      
        # 追加ここから
        def destroy
          movie = Movie.find(params[:id])
          movie.destroy
          redirect_to action: :index
        end
        # ここまで
      
        private
        def movie_params
          params.require(:movie).permit(:name, :genre, :day, :directorsname, :review, :degree)
        end
      
      
      
end
