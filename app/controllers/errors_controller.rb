class ErrorsController < ApplicationController

  def not_found
  end
  
  def internal_error
  end
  
  def routing
    unless params[:a].nil?
      logger.info "404 Error with: '#{params[:a]}'"
    end
    render :action => "not_found"
  end
  
end