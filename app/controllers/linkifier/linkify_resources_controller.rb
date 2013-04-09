require_dependency "linkifier/application_controller"

module Linkifier
  class LinkifyResourcesController < ApplicationController
    # GET /linkify_resources
    # GET /linkify_resources.json
    def index
      @linkify_resources = LinkifyResource.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @linkify_resources }
      end
    end
  
    # GET /linkify_resources/1
    # GET /linkify_resources/1.json
    def show
      @linkify_resource = LinkifyResource.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @linkify_resource }
      end
    end
  
    # GET /linkify_resources/new
    # GET /linkify_resources/new.json
    def new
      @linkify_resource = LinkifyResource.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @linkify_resource }
      end
    end
  
    # GET /linkify_resources/1/edit
    def edit
      @linkify_resource = LinkifyResource.find(params[:id])
    end
  
    # POST /linkify_resources
    # POST /linkify_resources.json
    def create
      @linkify_resource = LinkifyResource.new(params[:linkify_resource])
  
      respond_to do |format|
        if @linkify_resource.save
          format.html { redirect_to @linkify_resource, notice: 'Linkify resource was successfully created.' }
          format.json { render json: @linkify_resource, status: :created, location: @linkify_resource }
        else
          format.html { render action: "new" }
          format.json { render json: @linkify_resource.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /linkify_resources/1
    # PUT /linkify_resources/1.json
    def update
      @linkify_resource = LinkifyResource.find(params[:id])
  
      respond_to do |format|
        if @linkify_resource.update_attributes(params[:linkify_resource])
          format.html { redirect_to @linkify_resource, notice: 'Linkify resource was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @linkify_resource.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /linkify_resources/1
    # DELETE /linkify_resources/1.json
    def destroy
      @linkify_resource = LinkifyResource.find(params[:id])
      @linkify_resource.destroy
  
      respond_to do |format|
        format.html { redirect_to linkify_resources_url }
        format.json { head :no_content }
      end
    end
  end
end
