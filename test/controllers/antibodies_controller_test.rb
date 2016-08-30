require 'test_helper'

class AntibodiesControllerTest < ActionController::TestCase
  setup do
    @antibody = antibodies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:antibodies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create antibody" do
    assert_difference('Antibody.count') do
      post :create, antibody: { antibody_purifications_id: @antibody.antibody_purifications_id, antigen_description: @antibody.antigen_description, antigen_sequence: @antibody.antigen_sequence, clonality: @antibody.clonality, human_gene_id: @antibody.human_gene_id, isotype_id: @antibody.isotype_id, lot_identifier: @antibody.lot_identifier, organism_id: @antibody.organism_id, vendor_id: @antibody.vendor_id, vendor_product_identifier: @antibody.vendor_product_identifier, vendor_product_url: @antibody.vendor_product_url }
    end

    assert_redirected_to antibody_path(assigns(:antibody))
  end

  test "should show antibody" do
    get :show, id: @antibody
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @antibody
    assert_response :success
  end

  test "should update antibody" do
    patch :update, id: @antibody, antibody: { antibody_purifications_id: @antibody.antibody_purifications_id, antigen_description: @antibody.antigen_description, antigen_sequence: @antibody.antigen_sequence, clonality: @antibody.clonality, human_gene_id: @antibody.human_gene_id, isotype_id: @antibody.isotype_id, lot_identifier: @antibody.lot_identifier, organism_id: @antibody.organism_id, vendor_id: @antibody.vendor_id, vendor_product_identifier: @antibody.vendor_product_identifier, vendor_product_url: @antibody.vendor_product_url }
    assert_redirected_to antibody_path(assigns(:antibody))
  end

  test "should destroy antibody" do
    assert_difference('Antibody.count', -1) do
      delete :destroy, id: @antibody
    end

    assert_redirected_to antibodies_path
  end
end
