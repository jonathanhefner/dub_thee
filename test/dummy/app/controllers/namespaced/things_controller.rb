class Namespaced::ThingsController < ApplicationController
  before_action :set_namespaced_thing, only: [:show, :edit, :update, :destroy]

  # GET /namespaced/things
  def index
    @namespaced_things = Namespaced::Thing.all
  end

  # GET /namespaced/things/1
  def show
  end

  # GET /namespaced/things/new
  def new
    @namespaced_thing = Namespaced::Thing.new
  end

  # GET /namespaced/things/1/edit
  def edit
  end

  # POST /namespaced/things
  def create
    @namespaced_thing = Namespaced::Thing.new(namespaced_thing_params)

    if @namespaced_thing.save
      redirect_to @namespaced_thing, notice: 'Thing was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /namespaced/things/1
  def update
    if @namespaced_thing.update(namespaced_thing_params)
      redirect_to @namespaced_thing, notice: 'Thing was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /namespaced/things/1
  def destroy
    @namespaced_thing.destroy
    redirect_to namespaced_things_url, notice: 'Thing was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_namespaced_thing
      @namespaced_thing = Namespaced::Thing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def namespaced_thing_params
      params.require(:namespaced_thing).permit(:color)
    end
end
