require "application_system_test_case"

class MovementsTest < ApplicationSystemTestCase
  setup do
    @movement = movements(:one)
  end

  test "visiting the index" do
    visit movements_url
    assert_selector "h1", text: "Movements"
  end

  test "should create movement" do
    visit movements_url
    click_on "New movement"

    fill_in "Body", with: @movement.body
    fill_in "Keywords", with: @movement.keywords
    click_on "Create Movement"

    assert_text "Movement was successfully created"
    click_on "Back"
  end

  test "should update Movement" do
    visit movement_url(@movement)
    click_on "Edit this movement", match: :first

    fill_in "Body", with: @movement.body
    fill_in "Keywords", with: @movement.keywords
    click_on "Update Movement"

    assert_text "Movement was successfully updated"
    click_on "Back"
  end

  test "should destroy Movement" do
    visit movement_url(@movement)
    click_on "Destroy this movement", match: :first

    assert_text "Movement was successfully destroyed"
  end
end
