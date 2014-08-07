Feature: View categories
  As a visitor
  In order to view articles about certain topics
  I would like to view categories and articles within them

Scenario: View categories
    Given there are 5 categories
    When I visit the categories page
    Then I should see 5 categories
