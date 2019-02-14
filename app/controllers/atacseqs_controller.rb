class AtacseqsController < ApplicationController
  before_action :set_atacseq, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @atacseq
  end

  def new
    authorize Atacseq
    @atacseq = Atacseq.new
  end

  def edit
    authorize @atacseq
  end

  def create
    authorize Atacseq
    @atacseq = Atacseq.new(atacseq_params)

    respond_to do |format|
      if @atacseq.save
        format.html { redirect_to @atacseq, notice: 'ATAC-seq was successfully created.' }
        format.json { render json: @atacseq, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @atacseq.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @atacseq
    respond_to do |format|
      if @atacseq.update(atacseq_params)
        format.html { redirect_to @atacseq, notice: 'ATAC-seq was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @atacseq.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@atacseq, redirect_path_success: atacseq_path)
  end

  private
    def set_atacseq
      @atacseq = Atacseq.find(params[:id])
    end

    def atacseq_params
      params.require(:atacseq).permit(
        :description, 
        :name, 
        :notes,
        :submitter_comments
      )
    end
end
