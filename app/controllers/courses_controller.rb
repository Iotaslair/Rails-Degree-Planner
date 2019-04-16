class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new

    # TODO: Need to switch from gem 'ancestry' to 'acts_as_tree'
    # There is an issue in which you can't declare children (in ancestry) when the
    # model has not yet been saved. With acts_as_tree, this shouldn't be a problem.
    # The workaround is to only allow a prereq (children) to be declared when editing
    # an already existing course (model).

    @course = Course.new

    authorize @course
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new
    @course.title = course_params[:title]
    @course.description = course_params[:description]

    if course_params[:requirement] != nil
      @course.requirements << Requirement.find(course_params[:requirement])
    end

    authorize @course

    respond_to do |format|
      if @course.save

        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # TODO: Custom params whether creating or editing
    # E.g.
    def course_params
      # Permit params title, description, requirements, requirement (for specified requirement area id)
      params.require(:course).permit(:title, :description, :requirements, :requirement)
    end
end
