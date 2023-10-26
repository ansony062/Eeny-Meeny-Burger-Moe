class Public::TagsController < ApplicationController

    def show
      @tag = Tag.find(params[:id])
      @tags = Tag.all
    end


end
