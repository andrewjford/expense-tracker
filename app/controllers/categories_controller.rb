class CategoriesController < ApplicationController

  get '/categories' do
    @categories = current_user.categories
    erb :"/categories/index"
  end

  get '/categories/:slug' do
    
  end

  post '/categories' do
    if new_category = Category.new(name: params[:name], user: current_user)
      new_category.save
    else
      flash[:message] = "Category not added."
    end
    redirect '/categories'
  end

end
