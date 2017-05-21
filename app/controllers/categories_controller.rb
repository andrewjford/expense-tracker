class CategoriesController < ApplicationController

  get '/categories' do
    @categories = current_user.categories
    erb :"/categories/index"
  end

  get '/categories/:id' do
    @category = current_user.categories.find_by(id: params[:id])
    @filtered_expenses = current_user.expenses_by_category(@category)
    erb :"/categories/show"
  end

  get '/categories/:id/edit' do
    @category = current_user.categories.find_by(id: params[:id])
    @filtered_expenses = current_user.expenses_by_category(@category)
    erb :"/categories/edit"
  end

  post '/categories' do
    if new_category = Category.new(name: params[:name], user: current_user)
      new_category.save
    else
      flash[:message] = "Category not added."
    end
    redirect '/categories'
  end

  patch '/categories/:id' do
    category = current_user.categories.find_by(id: params[:id])
    category.update(name: params[:name]) if params[:name] != ""

    redirect "/categories/#{category.id}"
  end

  delete '/categories/:id' do
    category = current_user.categories.find_by(id: params[:id])
    if current_user.expenses.none?{|exp| exp.category == category}
      category.destroy
      redirect "/categories"
    else
      flash[:message] = "You may only delete categories with no expenses."
      redirect "/categories/#{category.id}"
    end
  end

end
