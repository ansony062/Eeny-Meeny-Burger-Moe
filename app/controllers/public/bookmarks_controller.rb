class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
end
