require 'test_helper'

class HumanDonorsControllerTest < ActionController::TestCase
  setup do
    @human_donor = human_donors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:human_donors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create human_donor" do
    assert_difference('HumanDonor.count') do
      post :create, human_donor: { encode_alias: @human_donor.encode_alias, encode_id: @human_donor.encode_id, string: @human_donor.string }
    end

    assert_redirected_to human_donor_path(assigns(:human_donor))
  end

  test "should show human_donor" do
    get :show, id: @human_donor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @human_donor
    assert_response :success
  end

  test "should update human_donor" do
    patch :update, id: @human_donor, human_donor: { encode_alias: @human_donor.encode_alias, encode_id: @human_donor.encode_id, string: @human_donor.string }
    assert_redirected_to human_donor_path(assigns(:human_donor))
  end

  test "should destroy human_donor" do
    assert_difference('HumanDonor.count', -1) do
      delete :destroy, id: @human_donor
    end

    assert_redirected_to human_donors_path
  end
end
