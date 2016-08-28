require 'test_helper'

class BiosamplesControllerTest < ActionController::TestCase
  setup do
    @biosample = biosamples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:biosamples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create biosample" do
    assert_difference('Biosample.count') do
      post :create, biosample: { culture_harvest_date: @biosample.culture_harvest_date, description: @biosample.description, encid: @biosample.encid, lot_identifier: @biosample.lot_identifier, passage_number: @biosample.passage_number, source_product_identifier: @biosample.source_product_identifier, submitter_comments: @biosample.submitter_comments, term_identifier: @biosample.term_identifier, term_name: @biosample.term_name }
    end

    assert_redirected_to biosample_path(assigns(:biosample))
  end

  test "should show biosample" do
    get :show, id: @biosample
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @biosample
    assert_response :success
  end

  test "should update biosample" do
    patch :update, id: @biosample, biosample: { culture_harvest_date: @biosample.culture_harvest_date, description: @biosample.description, encid: @biosample.encid, lot_identifier: @biosample.lot_identifier, passage_number: @biosample.passage_number, source_product_identifier: @biosample.source_product_identifier, submitter_comments: @biosample.submitter_comments, term_identifier: @biosample.term_identifier, term_name: @biosample.term_name }
    assert_redirected_to biosample_path(assigns(:biosample))
  end

  test "should destroy biosample" do
    assert_difference('Biosample.count', -1) do
      delete :destroy, id: @biosample
    end

    assert_redirected_to biosamples_path
  end
end
