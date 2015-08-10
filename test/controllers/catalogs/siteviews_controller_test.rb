require 'test_helper'

class Catalogs::SiteviewsControllerTest < ActionController::TestCase
  setup do
    @catalogs_siteview = catalogs_siteviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_siteviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_siteview" do
    assert_difference('Catalogs::Siteview.count') do
      post :create, catalogs_siteview: { completed: @catalogs_siteview.completed, contract_id: @catalogs_siteview.contract_id, visit_date: @catalogs_siteview.visit_date }
    end

    assert_redirected_to catalogs_siteview_path(assigns(:catalogs_siteview))
  end

  test "should show catalogs_siteview" do
    get :show, id: @catalogs_siteview
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalogs_siteview
    assert_response :success
  end

  test "should update catalogs_siteview" do
    patch :update, id: @catalogs_siteview, catalogs_siteview: { completed: @catalogs_siteview.completed, contract_id: @catalogs_siteview.contract_id, visit_date: @catalogs_siteview.visit_date }
    assert_redirected_to catalogs_siteview_path(assigns(:catalogs_siteview))
  end

  test "should destroy catalogs_siteview" do
    assert_difference('Catalogs::Siteview.count', -1) do
      delete :destroy, id: @catalogs_siteview
    end

    assert_redirected_to catalogs_siteviews_path
  end
end
