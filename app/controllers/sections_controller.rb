class SectionsController < ApplicationController
  # GET /sections
  # GET /sections.json
  def index
    @sections = Section.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @section = Section.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.json
  def new
    @section = Section.new(:name => params[:value])
    @section.resume_id = params[:pk]

    if @section.save
      render json: { :results => true }
    else
      render json: { :results => false }
    end
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(:name => params[:value])
    @section.resume_id = params[:pk]

    if @section.save
      render json: { :results => true }
    else
      render json: { :results => false }
    end
  end

  # PUT /sections/1
  # PUT /sections/1.json
  def update
    @section = Section.find(params[:id])
    @section.name = params[:value]
    
    if @section.save
      render json: { :results => true }
      #format.html { redirect_to @section, notice: 'Section was successfully updated.' }
      #format.json { head :no_content }
    else
      render json: { :results => false }
      #format.html { render action: "edit" }
      #format.json { render json: @section.errors, status: :unprocessable_entity }
    end
  
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    render nothing: true
  end
end
