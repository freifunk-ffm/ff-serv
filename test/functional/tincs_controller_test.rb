require 'test_helper'

class TincsControllerTest < ActionController::TestCase
  setup do
    @tinc = tincs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tincs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tinc" do
    assert_difference('Tinc.count') do
      post :create, tinc: { approved_at: @tinc.approved_at, approved_by: @tinc.approved_by, cert_data: @tinc.cert_data, certfp: @tinc.certfp, ip_adress: @tinc.ip_adress, node_id: @tinc.node_id, revoked_at: @tinc.revoked_at, revoked_by: @tinc.revoked_by }
    end

    assert_redirected_to tinc_path(assigns(:tinc))
  end

  test "should show tinc" do
    get :show, id: @tinc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tinc
    assert_response :success
  end

  test "should update tinc" do
    put :update, id: @tinc, tinc: { approved_at: @tinc.approved_at, approved_by: @tinc.approved_by, cert_data: @tinc.cert_data, certfp: @tinc.certfp, ip_adress: @tinc.ip_adress, node_id: @tinc.node_id, revoked_at: @tinc.revoked_at, revoked_by: @tinc.revoked_by }
    assert_redirected_to tinc_path(assigns(:tinc))
  end

  test "should destroy tinc" do
    assert_difference('Tinc.count', -1) do
      delete :destroy, id: @tinc
    end

    assert_redirected_to tincs_path
  end
end
