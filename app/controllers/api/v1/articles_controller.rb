class Api::V1::ArticlesController < ApplicationController
  before_action :set_article , only: [:show, :update, :destroy]
  before_action :check_token ,only: [:create]
  # GET /articles
  def index
    @articles = Article.all
    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    # byebug
    @article = Article.create(article_params)

    if @article
      render json: @article, status: :created, location: api_v1_article_url(@article)
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end






  private
  def check_token

    token = params[:article][:token]
    if   token == "123"

    else
      return render json: {
          message: "Unauthorized request",
          status: 401

      }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    # byebug
    @article = Article.find(params[:id])
  end

  # Only allow a trusted parameter “white list” through.
  def article_params

    params.require(:article).permit(:title, :content, :slug, :token)
  end
end