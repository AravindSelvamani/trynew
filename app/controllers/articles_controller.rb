 class ArticlesController < ApplicationController

   before_action :set_article, only:[:edit,:update,:show,:destroy]
   before_action :required_user, except:[:index, :show]
   before_action :required_same_user, only:[:edit,:update,:destroy]
   def new
     @article = Article.new
   end

   def edit
   end

   def index
     @articles = Article.all
     # @articles = Article.paginate(page: params[:page])
   end

   def create
     @article = Article.new(article_params)
     @article.user = current_user
     if @article.save
       flash[:success] = "Article is created successfully"
       redirect_to article_path(@article)
     else
       render :new
     end
   end

   def update
     if @article.update(article_params)
       flash[:success] = "Article is edited successfully"
       redirect_to article_path(@article)
     else
       render :edit
     end
   end

   def show
   end

   def destroy
     @article.destroy
     flash[:danger] = "Article is deleted successfully"
     redirect_to articles_path
   end

   private

   def set_article
     @article = Article.find(params[:id])
   end

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def required_same_user
      unless (current_user == @article.user) || current_user.admin?
        flash[:danger] = "Your are restricted to edit this article"
        redirect_to articles_path
      end
    end

 end
