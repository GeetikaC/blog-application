class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	
	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(params[:article].permit(:title, :body, :category_id, :publish_date, :feature_image_url, :is_published))
		if @article.save
			redirect_to article_path(@article.id), notice: "Article successfully created!"
		else
			render action: 'new'
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update_attributes(params[:article].permit(:title, :body, :category_id, :publish_date, :feature_image_url, :is_published))
			redirect_to article_path(@article.id), notice: "Article successfully updated!"
		else
			render action: 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path, notice: "Article successfully deleted!"
	end
end
