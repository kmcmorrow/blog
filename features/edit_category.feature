Feature: Edit a category
  As an admin
  In order to give relevant names to categories and
  unneccessary ones
  I would like to edit and delete categories

  Background:
    Given I am logged in
    And there is 1 category
    And I am on the categories page

  Scenario: Rename a category
    When I click the "Edit" link
    And I change the category name
    Then I should be on the categories page
    And I should see the new category name

  Scenario: Delete a category
    When I click the "Delete" link
    Then there should be 0 categories
    And I should be on the categories page
    And I should not see the category name

  Scenario: Redirect back to last page when form is cancelled
    When I click "Edit"
    And I click "Cancel"
    Then I should be on the categories page
