Feature: View articles
  As a visitor
  So that I can read the blog content
  I want to be able to view articles

  Scenario: View all articles
    Given there are 3 published articles
    When I visit the homepage
    Then I should see 3 articles
    And they should be sorted in reverse order of creation date

  Scenario: View an individual article
    Given there is 1 published article
    And I am on the homepage
    When I click on the article title
    Then I should be on the article page
    And I should see the article

  Scenario: Can't see published status
    Given there is 1 published article
    And I am on the article page
    Then I should not see the text "PUBLISHED"
    And I should not see an "Unpublish" link

  Scenario: Can't see draft articles
    Given there is 1 unpublished article
    And I am on the articles page
    Then I should not see the article

  Scenario: Unpublished article redirects to homepage
    Given there is 1 unpublished article
    When I visit the article page
    Then I should be on the homepage
