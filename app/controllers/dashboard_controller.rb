class DashboardController < ApplicationController
  def index
    # retrieve all Agents ordered by descending creation timestamp
    @person = Person.order('created_at desc')
  end
end
