Feature: Create categories
  As an admin
  In order to group articles
  I would like to create categories and assign articles to them

  Background:
    Given I am logged in

  Scenario: View categories
    Given there are 5 categories
    When I visit the categories page
    Then I should see all the categories
