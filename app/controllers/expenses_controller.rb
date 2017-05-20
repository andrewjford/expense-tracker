class ExpensesController < ApplicationController

  get '/expenses/new' do
    @categories = Category.all
    erb :"expenses/new"
  end

  post '/expenses' do
    if new_category = params[:new_category] != ""
      category = Category.find_or_create_by(name: new_category)
    else
      category = Category.find_by(name: params[existing_category])
    end

    redirect "/#{current_user.id}/"
  end

end
