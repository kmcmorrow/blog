Feature: Edit a category
  As an admin
  In order to give relevant names to categories
  I would like to edit a category's name

  Scenario: Rename a category
    Given there is 1 category
    And I am on the categories page
    When I click the "Edit" link
    And I change the category name
    Then I should be on the categories page
    And I should see the new category name
