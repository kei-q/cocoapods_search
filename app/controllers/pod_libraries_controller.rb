class PodLibrariesController < ApplicationController
  before_action :set_pod_library, only: [:show, :edit, :update, :destroy]

  # GET /pod_libraries
  # GET /pod_libraries.json
  def index
    pods_scope = PodLibrary.where('score IS NOT NULL').order(score: :desc)
    pods_scope = pods_scope.search(params[:q]) if params[:q]
    @pods = pods_scope.page(params[:page])
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
