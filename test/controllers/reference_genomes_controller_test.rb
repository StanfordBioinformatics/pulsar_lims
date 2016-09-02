require 'test_helper'

class ReferenceGenomesControllerTest < ActionController::TestCase
  setup do
    @reference_genome = reference_genomes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reference_genomes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reference_genome" do
    assert_difference('ReferenceGenome.count') do
      post :create, reference_genome: { name: @reference_genome.name, url: @reference_genome.url }
    end

    assert_redirected_to reference_genome_path(assigns(:reference_genome))
  end

  test "should show reference_genome" do
    get :show, id: @reference_genome
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reference_genome
    assert_response :success
  end

  test "should update reference_genome" do
    patch :update, id: @reference_genome, reference_genome: { name: @reference_genome.name, url: @reference_genome.url }
    assert_redirected_to reference_genome_path(assigns(:reference_genome))
  end

  test "should destroy reference_genome" do
    assert_difference('ReferenceGenome.count', -1) do
      delete :destroy, id: @reference_genome
    end

    assert_redirected_to reference_genomes_path
  end
end
