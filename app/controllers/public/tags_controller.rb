class Public::TagsController < ApplicationController
    
    def create
        
    end
    
    def edit
    end
    
    def update
        
    end
    
    def show
      @tag = Tag.find(params[:])
    end
    
  
end
