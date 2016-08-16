require 'test_helper'

class BiosampleTypesControllerTest < ActionController::TestCase
  setup do
    @biosample_type = biosample_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:biosample_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create biosample_type" do
    assert_difference('BiosampleType.count') do
      post :create, biosample_type: { name: @biosample_type.name }
    end

    assert_redirected_to biosample_type_path(assigns(:biosample_type))
  end

  test "should show biosample_type" do
    get :show, id: @biosample_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @biosample_type
    assert_response :success
  end

  test "should update biosample_type" do
    patch :update, id: @biosample_type, biosample_type: { name: @biosample_type.name }
    assert_redirected_to biosample_type_path(assigns(:biosample_type))
  end

  test "should destroy biosample_type" do
    assert_difference('BiosampleType.count', -1) do
      delete :destroy, id: @biosample_type
    end

    assert_redirected_to biosample_types_path
  end
end
