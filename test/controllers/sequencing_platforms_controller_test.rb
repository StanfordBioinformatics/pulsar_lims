require 'test_helper'

class SequencingPlatformsControllerTest < ActionController::TestCase
  setup do
    @sequencing_platform = sequencing_platforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sequencing_platforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sequencing_platform" do
    assert_difference('SequencingPlatform.count') do
      post :create, sequencing_platform: { name: @sequencing_platform.name }
    end

    assert_redirected_to sequencing_platform_path(assigns(:sequencing_platform))
  end

  test "should show sequencing_platform" do
    get :show, id: @sequencing_platform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sequencing_platform
    assert_response :success
  end

  test "should update sequencing_platform" do
    patch :update, id: @sequencing_platform, sequencing_platform: { name: @sequencing_platform.name }
    assert_redirected_to sequencing_platform_path(assigns(:sequencing_platform))
  end

  test "should destroy sequencing_platform" do
    assert_difference('SequencingPlatform.count', -1) do
      delete :destroy, id: @sequencing_platform
    end

    assert_redirected_to sequencing_platforms_path
  end
end
