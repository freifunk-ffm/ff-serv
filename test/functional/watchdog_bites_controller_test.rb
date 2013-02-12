require 'test_helper'

class WatchdogBitesControllerTest < ActionController::TestCase
  setup do
    @watchdog_bite = watchdog_bites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:watchdog_bites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create watchdog_bite" do
    assert_difference('WatchdogBite.count') do
      post :create, watchdog_bite: { log_data: @watchdog_bite.log_data, node_id: @watchdog_bite.node_id, node_stmp: @watchdog_bite.node_stmp, submission_stmp: @watchdog_bite.submission_stmp }
    end

    assert_redirected_to watchdog_bite_path(assigns(:watchdog_bite))
  end

  test "should show watchdog_bite" do
    get :show, id: @watchdog_bite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @watchdog_bite
    assert_response :success
  end

  test "should update watchdog_bite" do
    put :update, id: @watchdog_bite, watchdog_bite: { log_data: @watchdog_bite.log_data, node_id: @watchdog_bite.node_id, node_stmp: @watchdog_bite.node_stmp, submission_stmp: @watchdog_bite.submission_stmp }
    assert_redirected_to watchdog_bite_path(assigns(:watchdog_bite))
  end

  test "should destroy watchdog_bite" do
    assert_difference('WatchdogBite.count', -1) do
      delete :destroy, id: @watchdog_bite
    end

    assert_redirected_to watchdog_bites_path
  end
end
