class ArticlesController < ApplicationController

before_action :authenticate_user!, except: [:index, :show]
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def edit
    @article = Article.find(params[:id])

  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def upvote
    @article = Article.find(params[:id])
    @article.upvote_by(current_user)
    redirect_to request.referer
  end
  def downvote
    @article = Article.find(params[:id])
    @article.downvote_by(current_user)
    redirect_to request.referer
  end

  def update
    @article = Article.find(params[:id])
      if @article.update(article_params)
        redirect_to @article
      else
        if@article.user=current_user
        render 'edit'
      else
      @message = "It's not your comment wise guy :)"
      end
      redirect_to :back, notice: @message
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

end
