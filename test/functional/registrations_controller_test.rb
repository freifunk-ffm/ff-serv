require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Registration.count') do
      post :create, registration: { created_by: @registration.created_by, latitude: @registration.latitude, loc_str: @registration.loc_str, longitude: @registration.longitude, name: @registration.name, operator_email: @registration.operator_email, operator_name: @registration.operator_name, owner_id: @registration.owner_id, updated_by: @registration.updated_by }
    end

    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should show registration" do
    get :show, id: @registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @registration
    assert_response :success
  end

  test "should update registration" do
    put :update, id: @registration, registration: { created_by: @registration.created_by, latitude: @registration.latitude, loc_str: @registration.loc_str, longitude: @registration.longitude, name: @registration.name, operator_email: @registration.operator_email, operator_name: @registration.operator_name, owner_id: @registration.owner_id, updated_by: @registration.updated_by }
    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should destroy registration" do
    assert_difference('Registration.count', -1) do
      delete :destroy, id: @registration
    end

    assert_redirected_to registrations_path
  end
end
