class UpsTokensController < ApplicationController
  before_action :set_ups_token, only: %i[ show edit update destroy ]

  # GET /ups_tokens or /ups_tokens.json
  def index
    @ups_tokens = UpsToken.all
  end

  # GET /ups_tokens/1 or /ups_tokens/1.json
  def show
  end

  # GET /ups_tokens/new
  def new
    @ups_token = UpsToken.new
  end

  # GET /ups_tokens/1/edit
  def edit
  end

  # POST /ups_tokens or /ups_tokens.json
  def create
    @ups_token = UpsToken.new(ups_token_params)

    respond_to do |format|
      if @ups_token.save
        format.html { redirect_to @ups_token, notice: "Ups token was successfully created." }
        format.json { render :show, status: :created, location: @ups_token }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ups_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ups_tokens/1 or /ups_tokens/1.json
  def update
    respond_to do |format|
      if @ups_token.update(ups_token_params)
        format.html { redirect_to @ups_token, notice: "Ups token was successfully updated." }
        format.json { render :show, status: :ok, location: @ups_token }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ups_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ups_tokens/1 or /ups_tokens/1.json
  def destroy
    @ups_token.destroy!

    respond_to do |format|
      format.html { redirect_to ups_tokens_path, status: :see_other, notice: "Ups token was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ups_token
      @ups_token = UpsToken.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ups_token_params
      params.require(:ups_token).permit(:access_token, :refresh_token, :expires_at, :user_id)
    end
end
