class UsersController < ApplicationController
	@@superuser_usename = 'kumassy'
  before_action :check_superuser,only: [:show,:edit,:update,:export_words,:export_users]
	before_action :check_manager,only: [:index]
  before_action :set_user,only:[:show,:edit,:update]

  def index
    @users = User.all
  end
 
  def show
    # @user.words << Word.where(hinshi: 'noun')
    # @user.save
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'user was successfully updated.'
    else
     render :edit
   end
  end

  def my
  end

  def export_words
    @words = Word.all
  end

  def export_users
    @users = User.all
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username,:email,:commitment,:role)
    end

		def check_superuser
			# logger.debug current_user.username
			# logger.debug @@superuser_usename
			unless (current_user.username == @@superuser_usename )
				raise Forbidden
			end
		end
    def check_manager
      # logger.debug current_user.username
      # logger.debug @@superuser_usename
      unless (current_user.username == @@superuser_usename ) || ( current_user.role == 'manager')
        raise Forbidden
      end
    end 
end
