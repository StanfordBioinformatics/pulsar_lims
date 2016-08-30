require 'test_helper'

class HumanGenesControllerTest < ActionController::TestCase
  setup do
    @human_gene = human_genes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:human_genes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create human_gene" do
    assert_difference('HumanGene.count') do
      post :create, human_gene: { encode_identifier: @human_gene.encode_identifier, name: @human_gene.name }
    end

    assert_redirected_to human_gene_path(assigns(:human_gene))
  end

  test "should show human_gene" do
    get :show, id: @human_gene
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @human_gene
    assert_response :success
  end

  test "should update human_gene" do
    patch :update, id: @human_gene, human_gene: { encode_identifier: @human_gene.encode_identifier, name: @human_gene.name }
    assert_redirected_to human_gene_path(assigns(:human_gene))
  end

  test "should destroy human_gene" do
    assert_difference('HumanGene.count', -1) do
      delete :destroy, id: @human_gene
    end

    assert_redirected_to human_genes_path
  end
end
