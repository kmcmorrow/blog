Feature: View categories
  As a visitor
  In order to view articles about certain topics
  I would like to view categories and articles within them

  Background:
    Given there are 5 categories

  Scenario: View categories
    Given I am on the homepage
    When I click "Categories"
    Then I should see 5 categories

  Scenario: View all articles in a category
    Given I am on the categories page
    When I click on a category
    Then I should see the articles in that category
