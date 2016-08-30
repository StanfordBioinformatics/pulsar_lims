require 'test_helper'

class IsotypesControllerTest < ActionController::TestCase
  setup do
    @isotype = isotypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:isotypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create isotype" do
    assert_difference('Isotype.count') do
      post :create, isotype: { name: @isotype.name }
    end

    assert_redirected_to isotype_path(assigns(:isotype))
  end

  test "should show isotype" do
    get :show, id: @isotype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @isotype
    assert_response :success
  end

  test "should update isotype" do
    patch :update, id: @isotype, isotype: { name: @isotype.name }
    assert_redirected_to isotype_path(assigns(:isotype))
  end

  test "should destroy isotype" do
    assert_difference('Isotype.count', -1) do
      delete :destroy, id: @isotype
    end

    assert_redirected_to isotypes_path
  end
end
