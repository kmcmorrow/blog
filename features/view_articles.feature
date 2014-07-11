Feature: View articles
  As a visitor
  So that I can read the blog content
  I want to be able to view articles

  Scenario: View all articles
    Given there are 2 published articles
    When I visit the homepage
    Then I should see 2 articles

  Scenario: View an individual article
    Given there is 1 published article
    And I am on the homepage
    When I click on the article title
    Then I should be on the article page
    And I should see the article
