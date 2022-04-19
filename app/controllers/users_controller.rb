class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.order('rank ASC')
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.rank = User.all.length + 1
    @user.games_played = 0

    if @user.save
      redirect_to users_path, notice: "User was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "User was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    update_ranks_on_delete_user(@user.rank + 1, User.all.size)
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed."
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :surname, :email, :birthday, :games_played, :rank)
    end

    def update_ranks_on_delete_user(start, last)
      User.where(rank: (start..last)).to_a.each do |user|
        user.update(:rank => user.rank - 1)
      end
    end
end
