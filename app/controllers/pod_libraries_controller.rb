class PodLibrariesController < ApplicationController
  before_action :set_pod_library, only: [:show, :edit, :update, :destroy]

  # GET /pod_libraries
  # GET /pod_libraries.json
  def index
    @pods = PodLibrary.order(score: :desc).page(params[:page])
  end

  # GET /pod_libraries/1
  # GET /pod_libraries/1.json
  def show
  end

  # GET /pod_libraries/new
  def new
    @pod_library = PodLibrary.new
  end

  # GET /pod_libraries/1/edit
  def edit
  end

  # POST /pod_libraries
  # POST /pod_libraries.json
  def create
    @pod_library = PodLibrary.new(pod_library_params)

    respond_to do |format|
      if @pod_library.save
        format.html { redirect_to @pod_library, notice: 'Pod library was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pod_library }
      else
        format.html { render action: 'new' }
        format.json { render json: @pod_library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pod_libraries/1
  # PATCH/PUT /pod_libraries/1.json
  def update
    respond_to do |format|
      if @pod_library.update(pod_library_params)
        format.html { redirect_to @pod_library, notice: 'Pod library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pod_library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pod_libraries/1
  # DELETE /pod_libraries/1.json
  def destroy
    @pod_library.destroy
    respond_to do |format|
      format.html { redirect_to pod_libraries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pod_library
      @pod_library = PodLibrary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pod_library_params
      params[:pod_library]
    end
end
