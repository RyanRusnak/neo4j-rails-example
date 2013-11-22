class ContainsController < ApplicationController
  around_filter Neo4j::Rails::Transaction, :only => [:edit, :create, :update, :destroy]

  def show
    @contain = Contain.find(params[:id])
  end

  # Requires that the params :movie_id and :actor_id be set.
  # Since a contain is a relationship, it does not make sense
  # to create one without knowing the movie and actor.
  def new
    @first_node = Movie.find(params[:node_id])
    @second_node = Actor.find(params[:node_id])
    @contain = Contain.new
  end

  # Requires that the params :movie_id and :actor_id be set,
  # just like Role#new.  See above.
  def create
    @first_node = Movie.find(params[:node_id])
    @second_node = Actor.find(params[:node_id])
    @contain = @actor.roles_rels.connect(@movie, params[:contain])
    @contain.save
    redirect_to role_path(@contain.id)
  end

  def edit
    @contain = Contain.find(params[:id])
    @first_node = @contain.start_node
    @second_node = @contain.end_node
  end
  
  def update
    @contain = Contain.find(params[:id])
    if @contain.update_attributes(params[:contain])
      redirect_to(@contain, :notice => 'Role was successfully updated.')
    else
      @first_node = @contain.start_node
      @second_node = @contain.end_node
      render :action => "edit"
    end
  end

  def destroy
    @contain = Contain.find(params[:id])
    @first_node = @contain.start_node
    @contain.destroy
    redirect_to actor_path(@first_node)
  end
end
