class ExpensesController < ApplicationController

  get '/expenses/new' do
    @categories = current_user.categories
    erb :"expenses/new"
  end

  get '/expenses' do
    @expenses = current_user.expenses
    erb :"expenses/index"
  end

  post '/expenses' do

    #get category
    new_category = params[:new_category]
    if new_category != ""
      category = Category.find_or_create_by(name: new_category, user: current_user)
    else
      category = current_user.categories.find{|cat| cat.id == params[:existing_category]}
    end

    expense = Expense.new(date:params[:date],amount:params[:amount],
    vendor:params[:vendor],category: category,user: current_user)
    if expense.save
      redirect "/#{current_user.id}/"
    else
      redirect "/expenses/new"
    end
  end

end
