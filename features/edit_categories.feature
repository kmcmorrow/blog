Feature: Edit a category
  As an admin
  In order to give relevant names to categories and
  unneccessary ones
  I would like to edit and delete categories

  Background:
    Given I am logged in

  Scenario: Rename a category
    Given there is 1 category
    And I am on the categories page
    When I click the "Edit" link
    And I change the category name
    Then I should be on the categories page
    And I should see the new category name

  Scenario: Delete a category
    Given there is 1 category
    And I am on the categories page
    When I click the "Delete" link
    Then there should be 0 categories
    And I should be on the categories page
    And I should not see the category name
