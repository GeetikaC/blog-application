class CategoriesController < ApplicationController
	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def show
		@category = Category.find(params[:id])
	end

	def edit
		@category = Category.find(params[:id])
	end

	def create
		@category = Category.new(params[:category].permit(:name, :description))
		if @category.save
			redirect_to categories_path, notice: "Category added successfully!"
		else
			render action: 'new'
		end
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category].permit(:name, :description))
			redirect_to categories_path, notice: "Category updated successfully!"
		else
			render action: 'edit'
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to categories_path, notice: "Category deleted successfully!"
	end
end