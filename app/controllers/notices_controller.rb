class NoticesController < ApplicationController
  before_action :set_notice, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /notices or /notices.json
  def index
    @notices = current_user.notices.page(params[:page]).per(6)
  end

  # GET /notices/1 or /notices/1.json
  def show
  end

  # GET /notices/new
  def new
    @notice = Notice.new
  end

  # GET /notices/1/edit
  def edit
  end

  # POST /notices or /notices.json
  def create
    @notice = current_user.notices.build(notice_params)

    respond_to do |format|
      if @notice.save
        format.html { redirect_to new_notice_notice_images_path(@notice), notice: "Notice was successfully created." }
        format.json { render :show, status: :created, location: @notice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notices/1 or /notices/1.json
  def update
    respond_to do |format|
      if @notice.update(notice_params)

        redirect_path = @notice.images.attached? ? app_notice_path(@notice) : new_notice_notice_images_path(@notice)

        format.html { redirect_to redirect_path, notice: "Notice was successfully updated." }
        format.json { render :show, status: :ok, location: @notice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notices/1 or /notices/1.json
  def destroy
    @notice.destroy!

    respond_to do |format|
      format.html { redirect_to notices_url, notice: "Notice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_notice
    @notice = Notice.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def notice_params
    params.require(:notice).permit(:category, :location, :platform, :first_name, :last_name, :dob, :dod, :nickname, :wording, :relationship)
  end
end
