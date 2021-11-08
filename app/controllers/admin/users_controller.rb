class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction
  # GET /users or /users.json
  def index
    if params[:query].present?
      @pagy, @users = pagy(User.search(params[:query]), items: 2)
    elsif sort_column and sort_direction
      @pagy, @users = pagy(User.order(sort_column + ' ' + sort_direction), items: 3)
    else
      @pagy, @users = pagy(User.all, items: 3)
    end

    respond_to do |format|
      format.html
      format.csv { send_data User.all.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find params[:id]
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :role, :middle_name, :phone, :country, :type)
  end
end
