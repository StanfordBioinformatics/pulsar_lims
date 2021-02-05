class AtacseqsController < ApplicationController
  before_action :set_atacseq, only: [:show, :edit, :update, :destroy, :select_experimental_biosample, :select_biosample_libraries]
  skip_after_action :verify_authorized, only: [:select_experimental_biosample, :multiome, :snrna, :single_cell, :bulk, :select_biosample_libraries]

  def multiome
    title = "Multiome-Seq Experiments"
    redirect_to action: index, scope: :multiome, title: title
  end
  
  # small nuclear RNA-seq
  def snrna
    title = "Single Nuclear RNA-Seq Experiments"
    redirect_to action: index, scope: :snrna, title: title
  end
  
  def single_cell
    title = "Single Cell ATAC-Seq Experiments"
    redirect_to action: index, scope: :single_cell, title: title
  end

  def bulk
    title = "Bulk ATAC-Seq Experiments"
    redirect_to action: index, scope: :bulk, title: title
  end

  def select_experimental_biosample
    # AJAX from show view when user clicks on the "Add experiment replicate" button.
    @selection = Biosample.all
    render partial: "select_experimental_or_ctl_biosample", locals: {heading: "Add experimental replicates"}
  end

  def select_biosample_libraries                                                                       
    # AJAX call from partial in /views/application_partials/select_experimental_biosample when user 
    # selects a biosample.                       
    @biosample = Biosample.find(params[:biosample_id])                                                 
    # Filter out any Libraries from this Biosample that are already present on the experiment via 
    # the replicates attribute.
    @libraries = @biosample.libraries.reject { |x| x.atacseq_id == @atacseq.id}
    render layout: false                                                                               
  end   

  def index
    super
  end

  def show
    authorize @atacseq
    @scope = params[:scope]
  end

  def new
    authorize Atacseq
    scope = params[:scope]
    defaults = {}
    if scope.present?
      if scope == "single_cell"
        defaults = {single_cell: true}
        @new_title = "New Single-cell Atacseq"
      elsif scope == "snrna"
        defaults = {snrna: true}
        @new_title = "New Single-nuclear RNAseq"
      end 
    end
    @atacseq = Atacseq.new(defaults)
  end

  def edit
    authorize @atacseq
  end

  def create
    authorize Atacseq
    @atacseq = Atacseq.new(atacseq_params)
    @atacseq.user = current_user

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
    ddestroy(@atacseq, redirect_path_success: atacseqs_path)
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
        :single_cell,
        :snrna,
        :multiome,
        :submitter_comments,
        :upstream_identifier,
        :document_ids => [],
        :replicate_ids => [],
        documents_attributes: [:id, :_destroy]
      )
    end
end
