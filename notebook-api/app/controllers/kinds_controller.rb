class KindsController < ApplicationController
  before_action :set_kind, only: [:show, :update, :destroy]

  #Get /kinds
  def index
    @kinds = Kind.all

    render json: @kinds
  end

  #Get /kinds/1
  def show
    render json: @kind
  end

  #Post
  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      render json: @kind, status: :created, location: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  #Patch
  def update
    if @kind.update(kind_params)
      render json: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  #Delete
  def destroy
    @kind.destroy
  end

  private
    def set_kind
      if params[:contact_id]
        @kind = Contact.find(params[:contact_id]).kind
        return @kind
      end

      @kind = Kind.find(params[:id])
    end

    def kind_params
      params.require(:kind).permit(:description)
    end
end
