require 'test_helper'

class ExperimentTypesControllerTest < ActionController::TestCase
  setup do
    @experiment_type = experiment_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:experiment_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create experiment_type" do
    assert_difference('ExperimentType.count') do
      post :create, experiment_type: { name: @experiment_type.name }
    end

    assert_redirected_to experiment_type_path(assigns(:experiment_type))
  end

  test "should show experiment_type" do
    get :show, id: @experiment_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @experiment_type
    assert_response :success
  end

  test "should update experiment_type" do
    patch :update, id: @experiment_type, experiment_type: { name: @experiment_type.name }
    assert_redirected_to experiment_type_path(assigns(:experiment_type))
  end

  test "should destroy experiment_type" do
    assert_difference('ExperimentType.count', -1) do
      delete :destroy, id: @experiment_type
    end

    assert_redirected_to experiment_types_path
  end
end
