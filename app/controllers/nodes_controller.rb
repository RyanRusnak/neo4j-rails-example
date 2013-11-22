class NodesController < ApplicationController
  around_filter Neo4j::Rails::Transaction, :only => [:edit, :create, :update, :destroy]
  
  def index
    @nodes = Node.all
  end
  
  def show
    @node = Node.find(params[:id])
  end
  
  def new
    @node = Node.new
  end
  
  def edit
    @node = Node.find(params[:id])
  end
  
  def create
    @node = Node.new(params[:node])
    
    if @node.save
      redirect_to(@node, :notice => 'node was successfully created.')
    else
      render :action => "new"
    end
    
  end
  
  
  def update
    @node = Node.find(params[:id])
    if @node.update_attributes(params[:node])
      redirect_to(@node, :notice => 'node was successfully updated.') 
    else
      render :action => "edit"
    end
  end
  
  
   def destroy
    @node = Node.find(params[:id])
    @node.destroy
    redirect_to(actors_url)
  end

  def add_contain
    @node = Node.find(params[:id])
    @nodes = Node.all
  end

end

