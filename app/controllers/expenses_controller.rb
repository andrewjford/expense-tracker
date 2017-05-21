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
      category = current_user.categories.find(params[:existing_category])
    end

    expense = Expense.new(date:params[:date],amount:params[:amount],
    vendor:params[:vendor],category: category,user: current_user)
    if expense.save
      redirect "/expenses"
    else
      redirect "/expenses/new"
    end
  end

  get '/expenses/:id' do
    expense = current_user.expenses.find_by(id: params[:id])
    if expense
      expense.destroy
    end
    redirect "/expenses"
  end
end
