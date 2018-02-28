class AnalysesController < ApplicationController
  before_action :set_analysis, only: [:show, :edit, :update, :destroy]
	skip_after_action :verify_authorized, only: [:add_merged_file]


	def add_merged_file
		@analysis = Analysis.new
		@file_attr = params[:attr].to_sym
    logger.info(@file_attr == :merged_peaks_file)
		if @file_attr == :merged_bam_file
			@file_reference = @analysis.build_merged_bam_file({user_id: current_user.id,data_file_type_id: DataFileType.find_by(name: "BAM").id})
		elsif @file_attr == :merged_peaks_file
			@file_reference = @analysis.build_merged_peaks_file({user_id: current_user.id, data_file_type_id: DataFileType.find_by(name: "BED").id})
		elsif @file_attr == :merged_qc_file
			@file_reference = @analysis.build_merged_qc_file({user_id: current_user.id})
		end
		render partial: "add_merged_file", layout: false
	end

  def index
    @analyses = policy_scope(Analysis).page params[:page]
  end

  def show
		authorize @analysis
  end

  def new
		authorize Analysis
    @analysis = Analysis.new
  end

  def edit
		authorize @analysis
  end

  def create
		authorize Analysis
    @analysis = Analysis.new(analysis_params)
		@analysis.user = current_user

    respond_to do |format|
      if @analysis.save
        format.html { redirect_to @analysis, notice: 'Analysis was successfully created.' }
        format.json { render json: @analysis, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @analysis
    respond_to do |format|
      if @analysis.update(analysis_params)
        format.html { redirect_to @analysis, notice: 'Analysis was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @analysis
    @analysis.destroy
    respond_to do |format|
      format.html { redirect_to analyses_url }
      format.json { head :no_content }
    end
  end

  private
    def set_analysis
      @analysis = set_record(controller_name,params[:id])
    end

    def analysis_params
      params.require(:analysis).permit(:protocol_id, :single_cell_sorting_id, :merged_bam_file_id, :merged_peaks_file_id, :merged_qc_file_id, :description, merged_bam_file_attributes: [:user_id, :data_storage_id, :file_path, :fileid, :data_file_type_id], merged_peaks_file_attributes: [:user_id, :data_storage_id, :file_path, :fileid, :data_file_type_id], merged_qc_file_attributes: [:user_id, :data_storage_id, :file_path, :fileid, :data_file_type_id])
    end
end
