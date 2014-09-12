Feature: Category menu
  As a visitor
  In order to quickly view a specific category
  I should see a menu with links to all categories

  Scenario: View the category menu
    Given there are 5 categories
    And I am on the homepage
    Then I should see the category menu
