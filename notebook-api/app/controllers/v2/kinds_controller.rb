module V2
  class KindsController < ApplicationController

    #Devise Token Auth
    before_action :authenticate_user!

    #BASIC
    # include ActionController::HttpAuthentication::Basic::ControllerMethods
    # http_basic_authenticate_with name: "admin", password: "admin@123"

    #DIGEST
    # include ActionController::HttpAuthentication::Digest::ControllerMethods
    # USERS = { "dap" => Digest::MD5.hexdigest(["dap",REALM,"secret"].join(":"))}
    # include ActionController::HttpAuthentication::Digest::ControllerMethods
    # USERS = { "admin" => Digest::MD5.hexdigest(["admin","Application","admin@123"].join(":"))}

    #TOKEN
    #TOKEN = ENV['TOKEN']

    #include ActionController::HttpAuthentication::Token::ControllerMethods

    #before_action :authenticate

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

      # def authenticate
      #   #DIGEST
      #   # authenticate_or_request_with_http_digest("Application") do |username|
      #   #   USERS[username]
      #   # end

      #   #TOKEN
      #   # authenticate_or_request_with_http_token do |token, options|
      #   #   # Compare the tokens in a time-constant manner, to mitigate
      #   #   # timing attacks.
      #   #   # https://en.wikipedia.org/wiki/Timing_attack
      #   #   # https://rubsphp.blogspot.com/2014/03/prevencao-de-timing-attack-no-php.html?m=0
      #   #   ActiveSupport::SecurityUtils.secure_compare(
      #   #     ::Digest::SHA256.hexdigest(token),
      #   #     ::Digest::SHA256.hexdigest(TOKEN)
      #   #   )
      #   # end

      #   #JWT
      #   authenticate_or_request_with_http_token do |token, options|
      #     hmac_secret = ENV['TOKEN']
      #     JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
      #   end
      # end
  end
end
