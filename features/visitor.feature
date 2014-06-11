Feature: Display all published articles
  As a visitor
  So that I can find the latest articles to read
  I want to see all articles sorted by published date

  Scenario: View all articles
    Given there are 2 published articles
    And I visit the homepage
    Then I should see 2 articles
