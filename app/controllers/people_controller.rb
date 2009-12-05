require "rexml/document"

class PeopleController < ApplicationController
  around_filter :neo_tx
    
  # GET /people
  def index
    @people = Person.all.nodes
  
  end

  def updated_view_mode(view_mode)
    v_m = 'all'
    v_m = session[:view_mode] if session[:view_mode]
    v_m = view_mode if view_mode
    session[:view_mode] = v_m
    v_m
  end

  # GET /people/1
  def show
    @view_mode = updated_view_mode(params[:view_mode])

    if ['add_as_friend', 'delete_as_friend'].include?(params[:method])
      @person.send(params[:method], params[:person_id])
    end

    @people = Person.all.nodes
    @direct_friends = @person.friends.depth(1)
    
    opts = {}
    case @view_mode
    when 'depth_one'
      opts = {:persons_to_highlight => @direct_friends, :root_person => @person}
    when 'depth_all'
      opts = {:persons_to_highlight => @person.friends.depth(:all), :root_person => @person}
    end

    svg_generator = SVGGenerator.new
    svg_generator.create_image(@people, opts)
    @height = svg_generator.image_height(440)
  end

  # GET /people/new
  def new
    @person = Person.value_object.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new
    @person.update(params[:person])
    flash[:notice] = 'Person was successfully created.'
    redirect_to(@person)
  end

  # PUT /people/1
  def update
    @person.update(params[:person])
    flash[:notice] = 'Person was successfully updated.'
    redirect_to(@person)
  end

  # DELETE /people/1
  def destroy
    @person.delete
    redirect_to(people_url)
  end


  private

  def neo_tx
    Neo4j::Transaction.new
    @person = Neo4j.load(params[:id]) if params[:id]
    yield
    Neo4j::Transaction.finish
  end

end
