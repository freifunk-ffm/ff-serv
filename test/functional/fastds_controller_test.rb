require 'test_helper'

class FastdsControllerTest < ActionController::TestCase
  setup do
    @fastd = fastds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fastds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fastd" do
    assert_difference('Fastd.count') do
      post :create, fastd: { fw_version: @fastd.fw_version, key: @fastd.key, node_id: @fastd.node_id }
    end

    assert_redirected_to fastd_path(assigns(:fastd))
  end

  test "should show fastd" do
    get :show, id: @fastd
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fastd
    assert_response :success
  end

  test "should update fastd" do
    put :update, id: @fastd, fastd: { fw_version: @fastd.fw_version, key: @fastd.key, node_id: @fastd.node_id }
    assert_redirected_to fastd_path(assigns(:fastd))
  end

  test "should destroy fastd" do
    assert_difference('Fastd.count', -1) do
      delete :destroy, id: @fastd
    end

    assert_redirected_to fastds_path
  end
end
