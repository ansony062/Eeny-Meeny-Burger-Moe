class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!
end
