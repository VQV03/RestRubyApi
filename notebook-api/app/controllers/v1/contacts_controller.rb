module V1
  class ContactsController < ApplicationController
    include ErrorSerializer

    before_action :set_contact, only: [:show, :update, :destroy]

    # GET /contacts
    def index
      #Query Parameters
      # if params[:version] == "1"
      #   @contacts = Contact.all
      # elsif params[:version] == "2"
      #   @contacts = Contact.last(5)
      # end

      page_number = params[:page].try(:[], :number)
      per_page = params[:page].try(:[], :size)

      @contacts = Contact.all.page(page_number).per(per_page)
      
      # expires_in 30.seconds, public: true # Cache Controll
      # paginate json: @contacts #, methods: :birthdate_br #[:hello, :i18n]
      if stale?(etag: @contacts) #(last_modified: @contacts[0].updated_at)
        render json: @contacts #, methods: :birthdate_br #[:hello, :i18n]
      end
    end

    # GET /contacts/1
    def show
      render json: @contact, include: [:kind, :address, :phones] #, meta: { author: "Vitor Queiroz" }
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, include: [:kind, :phones, :address], status: :created, location: @contact
      else
        render json: ErrorSerializer.serialize(@contact.errors) # @contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, include: [:kind, :phones, :address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def contact_params
        #params.require(:contact).permit(:name, :email, :birthdate, :kind_id, phones_attributes:[:id, :number, :_destroy], address_attributes: [:id, :street, :city])
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end
