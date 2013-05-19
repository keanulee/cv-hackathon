class ResumesController < ApplicationController
  before_filter :authenticate_user!

  # GET /resumes
  # GET /resumes.json
  def index
    @contact_info = current_user.contact_info
    @resumes = Resume.all( :conditions => { :user_id => current_user.id }, :include => { :sections => :parts } )
    #puts YAML::dump(@jsonresumes)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resumes.as_json(
        :include => { :sections => { :include => :parts } } ) }
    end
  end



  # GET /resumes/1
  # GET /resumes/1.json
  def show
    @resume = Resume.find(params[:id])

    respond_to do |format|
      format.html { redirect_to :action => :index }
      format.json { render json: {
        resume: @resume.as_json( :include => { :sections => { :include => :parts } } ),
        contact_info: current_user.contact_info.to_json
      } }
    end
  end


  # GET /resumes/new
  # GET /resumes/new.json
  def new
    @resume = Resume.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resume }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = current_user.resumes.new(params[:resume])

    respond_to do |format|
      if @resume.save
        format.html { redirect_to @resume, notice: 'Resume was successfully created.' }
        format.json { render json: @resume, status: :created, location: @resume }
      else
        format.html { render action: "new" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    if params[:pk]
      @resume = Resume.find(params[:pk])
      @resume.update_attributes( params[:name] => params[:value] )
      
      if @resume.save
        render json: { :results => true }
      else
        render json: { :results => false }
      end
    else
      @resume = Resume.find(params[:id])

      respond_to do |format|
        if @resume.update_attributes(params[:resume])
          format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @resume.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    render nothing: true
  end

  def copy
    @resume = Resume.find(params[:id]).dup( :include => { :sections => :parts } )
    @resume.name = "#{@resume.name} (copy)"
    @resume.save

    redirect_to resumes_url
  end
end
