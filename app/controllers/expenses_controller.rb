class ExpensesController < ApplicationController

  get '/expenses/new' do
    if logged_in?
      @categories = current_user.categories
      erb :"expenses/new"
    else
      redirect '/login'
    end
  end

  #show all expenses
  get '/expenses/all' do
    if logged_in?
      @expenses = current_user.expenses
      #sort expenses by date (first being most recent)
      @expenses = @expenses.sort_by {|expense| expense.date}.reverse
      erb :"expenses/all"
    else
      redirect '/login'
    end
  end

  get '/expenses/:id' do
    if logged_in?
      if @expense = current_user.expenses.find_by(id: params[:id])
        erb :"expenses/show"
      else
        redirect '/'
      end
    else
      redirect '/login'
    end
  end

  #default expenses view, limits to most recent 20
  get '/expenses' do
    if logged_in?
      @expenses = current_user.expenses
      #sort expenses by date (first being most recent), then only take first 20
      @expenses = @expenses.sort_by {|expense| expense.date}.reverse.first(20)
      erb :"expenses/index"
    else
      redirect '/login'
    end
  end

  get '/expenses/:id/edit' do
    @expense = current_user.expenses.find_by(id: params[:id])
    if @expense
      erb :"/expenses/edit"
    else
      redirect "/expenses/#{params[:id]}"
    end
  end

  #shows only expenses with the given description
  get '/expenses/vendors/:vendor' do
    @vendor = params[:vendor]
    @filtered_expenses = current_user.expenses_by_vendor(@vendor)
    erb :"/expenses/vendor"
  end

  post '/expenses' do
    #get category
    new_category = params[:new_category]

    if new_category != ""  #if new category field has content
      category = Category.find_or_create_by(name: new_category, user: current_user)

    #this will trigger if user chooses no category or new category
    elsif new_category == "" && params[:existing_category] == nil
      category = nil

    #should fall to this when a radio button is selected
    else
      category = current_user.categories.find(params[:existing_category])
    end

    #make new expense
    expense = Expense.new(date:params[:date],amount:params[:amount],
    vendor:params[:vendor],category: category,user: current_user)
    if expense.save
      flash[:message] = "Added expense."
      redirect "/expenses"
    else
      flash[:message] = "Please enter a valid date,amount, and category."
      redirect "/expenses/new"
    end
  end

  patch '/expenses/:id' do
    @expense = current_user.expenses.find_by(id: params[:id])
    category = current_user.categories.find_or_create_by(name: params[:category][:name])
    if @expense && @expense.update(date: params[:date], category: category,
      vendor: params[:vendor], amount: params[:amount])
      flash[:message] = @expense.errors.full_messages.join(', ')
      redirect "/expenses/#{params[:id]}"
    else
      erb :"/expenses/edit"
    end
  end

  delete '/expenses/:id' do
    expense = current_user.expenses.find_by(id: params[:id])
    if expense
      flash[:message] = "Expense deleted."
      expense.destroy
    end
    redirect "/expenses"
  end
end
