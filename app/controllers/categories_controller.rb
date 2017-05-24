class CategoriesController < ApplicationController

  get '/categories' do
    @categories = current_user.categories
    erb :"/categories/index"
  end

  get '/categories/:slug' do
    @category = Category.find_by_slug(params[:slug],current_user)
    @filtered_expenses = current_user.expenses_by_category(@category)
    erb :"/categories/show"
  end

  get '/categories/:slug/edit' do
    @category = Category.find_by_slug(params[:slug],current_user)
    @filtered_expenses = current_user.expenses_by_category(@category)
    erb :"/categories/edit"
  end

  get '/categories/:slug/:month' do
    @category = Category.find_by_slug(params[:slug],current_user)
    @filtered_expenses = current_user.expenses_by_category_and_month(@category,
      params[:month].to_i)
    erb :"/categories/show"
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

    redirect "/categories/#{category.slug}"
  end

  delete '/categories/:id' do
    category = current_user.categories.find_by(id: params[:id])
    if current_user.expenses.none?{|exp| exp.category == category}
      flash[:message] = "Category #{category.name} deleted."
      category.destroy
      redirect "/categories"
    else
      flash[:message] = "You may only delete categories with no expenses."
      redirect "/categories/#{category.slug}"
    end
  end

end
