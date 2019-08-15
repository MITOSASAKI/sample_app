class StaticPagesController < ApplicationController

  def home
    render html: 'Home' 
   end

end
