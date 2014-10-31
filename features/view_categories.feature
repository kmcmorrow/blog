Feature: View categories
  As a visitor
  In order to view articles about certain topics
  I would like to view categories and articles within them

  Background:
    Given there are 5 categories

  Scenario: View categories
    Given there is a category called "ZZZ"
    And there is a category called "AAA"
    And I am on the homepage
    When I click "Categories"
    Then I should see all the categories in alphabetical order

  Scenario: View all published articles in a category when logged out
    Given there are 2 published articles in the first category
    And there are 2 draft articles in the first category
    And I am on the categories page
    When I click on the first category
    Then I should see the published articles in the first category
    And I should not see the draft articles in the first category

  Scenario: View all published and draft articles in a category when logged in
    Given I am logged in
    And there are 2 published articles in the first category
    And there are 2 draft articles in the first category
    And I am on the categories page
    When I click on the first category
    Then I should see the articles in the first category

  Scenario: View all of an articles categories on an article page
    Given there is an article with 3 categories
    When I visit the article page
    Then I should see links to the categories

  Scenario: View 5 articles per page
    Given there are 6 published articles in the first category
    And I am on the categories page
    When I click on the first category
    Then I should see 5 articles
    When I click "Next"
    Then I should see 1 article
