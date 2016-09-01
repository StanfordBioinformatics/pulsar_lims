require 'test_helper'

class LibrariesControllerTest < ActionController::TestCase
  setup do
    @library = libraries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:libraries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create library" do
    assert_difference('Library.count') do
      post :create, library: { antibody_id: @library.antibody_id, biosample_id: @library.biosample_id, lot_identifier: @library.lot_identifier, sequence_ontology_term_id: @library.sequence_ontology_term_id, size_range: @library.size_range, strand_specificity: @library.strand_specificity, vendor_id: @library.vendor_id, vendor_product_identifier: @library.vendor_product_identifier }
    end

    assert_redirected_to library_path(assigns(:library))
  end

  test "should show library" do
    get :show, id: @library
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @library
    assert_response :success
  end

  test "should update library" do
    patch :update, id: @library, library: { antibody_id: @library.antibody_id, biosample_id: @library.biosample_id, lot_identifier: @library.lot_identifier, sequence_ontology_term_id: @library.sequence_ontology_term_id, size_range: @library.size_range, strand_specificity: @library.strand_specificity, vendor_id: @library.vendor_id, vendor_product_identifier: @library.vendor_product_identifier }
    assert_redirected_to library_path(assigns(:library))
  end

  test "should destroy library" do
    assert_difference('Library.count', -1) do
      delete :destroy, id: @library
    end

    assert_redirected_to libraries_path
  end
end
