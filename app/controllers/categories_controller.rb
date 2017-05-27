class CategoriesController < ApplicationController

  get '/categories' do
    if logged_in?
      @categories = current_user.categories
      erb :"/categories/index"
    else
      redirect '/'
    end
  end

  get '/categories/:slug' do
    if logged_in?
      @category = Category.find_by_slug(params[:slug],current_user)
      @filtered_expenses = current_user.expenses_by_category(@category)
      erb :"/categories/show"
    else
      redirect '/'
    end
  end

  get '/categories/:slug/edit' do
    if logged_in?
      @category = Category.find_by_slug(params[:slug],current_user)
      @filtered_expenses = current_user.expenses_by_category(@category)
      erb :"/categories/edit"
    else
      redirect '/'
    end
  end

  #for report restricted by category and month
  get '/categories/:slug/:month' do
    if logged_in?
      @category = Category.find_by_slug(params[:slug],current_user)
      @filtered_expenses = current_user.expenses_by_category_and_month(@category,
        params[:month].to_i)
      erb :"/categories/show"
    else
      redirect '/'
    end
  end

  post '/categories' do
    new_category = Category.find_or_initialize_by(name: params[:name], user: current_user)
    if !new_category.save
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

    #check if there exist any expenses with this category
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
