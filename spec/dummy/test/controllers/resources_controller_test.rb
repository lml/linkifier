require "minitest_helper"

class ResourcesControllerTest < ActionController::TestCase

  before do
    @resource = resources(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:resources)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Resource.count') do
      post :create, resource: {  }
    end

    assert_redirected_to resource_path(assigns(:resource))
  end

  def test_show
    get :show, id: @resource
    assert_response :success
  end

  def test_edit
    get :edit, id: @resource
    assert_response :success
  end

  def test_update
    put :update, id: @resource, resource: {  }
    assert_redirected_to resource_path(assigns(:resource))
  end

  def test_destroy
    assert_difference('Resource.count', -1) do
      delete :destroy, id: @resource
    end

    assert_redirected_to resources_path
  end
end
