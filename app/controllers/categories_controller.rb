class CategoriesController < ApplicationController

  get '/categories' do
    @categories = current_user.categories
    erb :"/categories/index"
  end

  post '/categories' do
    @categories = current_user.categories
    erb :"/categories/new"
  end

end
