require_dependency "as_user/application_controller"

module AsUser
  class UsersController < ApplicationController
    before_filter :signed_in_as_self, except: [:index, :show, :new, :create]

    # GET /users
    # GET /users.json
    def index
      @users = User.order("created_at desc").page([params[:page].to_i, 1].max).per(100)
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    end
  
    # GET /users/1
    # GET /users/1.json
    def show
      @user = User.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end
  
    # GET /users/new
    # GET /users/new.json
    def new
      @user = User.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    end
  
    # POST /users
    # POST /users.json
    def create
      @user = User.new(params[:user])
  
      respond_to do |format|
        if @user.save
          sign_in @user
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          flash[:error]="create user failed."
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # GET /users/1/edit
    def edit
    end
  
    def edit_password
    end
  
    # PUT /users/1
    # PUT /users/1.json
    def update
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          flash[:error] = "update password failed."
          format.html { redirect_to @user }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      #@user = User.find(params[:id])
      @user.destroy
  
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end

    private
    def signed_in_as_self
      @user = User.find(params[:id])
      if current_user
        unless current_user?(@user)
          flash[:error] = "can only modify your own account."
          redirect_to main_app.root_path
        end
      else
        store_location
        redirect_to signin_path
      end
    end
  end
end
