require 'test_helper'

class UberonsControllerTest < ActionController::TestCase
  setup do
    @uberon = uberons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uberons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uberon" do
    assert_difference('Uberon.count') do
      post :create, uberon: { accession: @uberon.accession, name: @uberon.name }
    end

    assert_redirected_to uberon_path(assigns(:uberon))
  end

  test "should show uberon" do
    get :show, id: @uberon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uberon
    assert_response :success
  end

  test "should update uberon" do
    patch :update, id: @uberon, uberon: { accession: @uberon.accession, name: @uberon.name }
    assert_redirected_to uberon_path(assigns(:uberon))
  end

  test "should destroy uberon" do
    assert_difference('Uberon.count', -1) do
      delete :destroy, id: @uberon
    end

    assert_redirected_to uberons_path
  end
end
