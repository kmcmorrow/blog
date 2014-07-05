Feature: View an article
  As a visitor
  So that I can read an article and it's comments
  I want to view an individual article

  Scenario: View an article
    Given there is 1 published article
    And I am on the homepage
    When I click on the article title
    Then I should be on the article page
    And I should see the article
