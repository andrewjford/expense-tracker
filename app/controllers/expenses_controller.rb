class ExpensesController < ApplicationController

  get '/expenses/new' do
    erb :"expenses/new"
  end
end
