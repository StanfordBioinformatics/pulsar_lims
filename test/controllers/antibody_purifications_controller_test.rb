require 'test_helper'

class AntibodyPurificationsControllerTest < ActionController::TestCase
  setup do
    @antibody_purification = antibody_purifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:antibody_purifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create antibody_purification" do
    assert_difference('AntibodyPurification.count') do
      post :create, antibody_purification: { name: @antibody_purification.name }
    end

    assert_redirected_to antibody_purification_path(assigns(:antibody_purification))
  end

  test "should show antibody_purification" do
    get :show, id: @antibody_purification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @antibody_purification
    assert_response :success
  end

  test "should update antibody_purification" do
    patch :update, id: @antibody_purification, antibody_purification: { name: @antibody_purification.name }
    assert_redirected_to antibody_purification_path(assigns(:antibody_purification))
  end

  test "should destroy antibody_purification" do
    assert_difference('AntibodyPurification.count', -1) do
      delete :destroy, id: @antibody_purification
    end

    assert_redirected_to antibody_purifications_path
  end
end
