class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit, :update, :destroy]
  def index
    @styles = Style.all
  end


  def show
  end

  def new
    @style = Style.new
  end

  def create
    @style = Style.new params.require(:style).permit(:name, :description)

    if current_user.nil?
      redirect_to signin_path, notice:'you should be signed in'
    elsif @style.save
      redirect_to styles_path
    else
      render :new
    end
  end

  def destroy
    style = Style.find(params[:id])
    style.delete if current_user
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_style
    @style = Style.find(params[:id])
  end
end