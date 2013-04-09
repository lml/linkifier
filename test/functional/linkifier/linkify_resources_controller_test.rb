require 'test_helper'

module Linkifier
  class LinkifyResourcesControllerTest < ActionController::TestCase
    setup do
      @linkify_resource = linkify_resources(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:linkify_resources)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create linkify_resource" do
      assert_difference('LinkifyResource.count') do
        post :create, linkify_resource: { linkify_resource_id: @linkify_resource.linkify_resource_id, resource_id: @linkify_resource.resource_id, resource_type: @linkify_resource.resource_type }
      end
  
      assert_redirected_to linkify_resource_path(assigns(:linkify_resource))
    end
  
    test "should show linkify_resource" do
      get :show, id: @linkify_resource
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @linkify_resource
      assert_response :success
    end
  
    test "should update linkify_resource" do
      put :update, id: @linkify_resource, linkify_resource: { linkify_resource_id: @linkify_resource.linkify_resource_id, resource_id: @linkify_resource.resource_id, resource_type: @linkify_resource.resource_type }
      assert_redirected_to linkify_resource_path(assigns(:linkify_resource))
    end
  
    test "should destroy linkify_resource" do
      assert_difference('LinkifyResource.count', -1) do
        delete :destroy, id: @linkify_resource
      end
  
      assert_redirected_to linkify_resources_path
    end
  end
end
