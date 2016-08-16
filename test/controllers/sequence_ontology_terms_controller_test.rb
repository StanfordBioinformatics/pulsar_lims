require 'test_helper'

class SequenceOntologyTermsControllerTest < ActionController::TestCase
  setup do
    @sequence_ontology_term = sequence_ontology_terms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sequence_ontology_terms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sequence_ontology_term" do
    assert_difference('SequenceOntologyTerm.count') do
      post :create, sequence_ontology_term: { accession: @sequence_ontology_term.accession, definition: @sequence_ontology_term.definition, name: @sequence_ontology_term.name }
    end

    assert_redirected_to sequence_ontology_term_path(assigns(:sequence_ontology_term))
  end

  test "should show sequence_ontology_term" do
    get :show, id: @sequence_ontology_term
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sequence_ontology_term
    assert_response :success
  end

  test "should update sequence_ontology_term" do
    patch :update, id: @sequence_ontology_term, sequence_ontology_term: { accession: @sequence_ontology_term.accession, definition: @sequence_ontology_term.definition, name: @sequence_ontology_term.name }
    assert_redirected_to sequence_ontology_term_path(assigns(:sequence_ontology_term))
  end

  test "should destroy sequence_ontology_term" do
    assert_difference('SequenceOntologyTerm.count', -1) do
      delete :destroy, id: @sequence_ontology_term
    end

    assert_redirected_to sequence_ontology_terms_path
  end
end
