Feature: Create categories
  As an admin
  In order to group articles
  I would like to create categories and assign articles to them

  Background:
    Given I am logged in

  Scenario: Create a new category
    Given I am on the categories page
    When I create a new category
    Then I should be on the categories page
    And I should see the new category
