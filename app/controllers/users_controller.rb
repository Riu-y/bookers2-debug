class UsersController < ApplicationController
  before_action :authenticate_user! , only: [:show, :new, :index, :edit]
	before_action :baria_user, only: [:edit,:update]
  # before_action :correct_user,only:[:edit, :update, :destroy]
  def show
  	@user = User.find(params[:id])
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @user = current_user
  end

  def edit
  	@user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user.id == current_user.id
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		redirect_to user_path(@user.id), notice: "successfully updated user!"
  	else
  		render 'edit'
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
    end
    # def correct_user
    #   @user = User.find(params[:id])
    #   redirect_to(root_path) unless current_user?(@user)
    # end
    end
end