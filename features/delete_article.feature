Feature: Delete an aricle
  As an admin
  So that I can remove useless/irrelevant articles
  I want to delete an article

  Scenario: Try to delete article when not logged in
    Given there is 1 published article
    When I visit the article page
    Then I should not see a "Delete article" link

  Scenario: Log in and delete article
    Given there is 1 published article
    And I am logged in
    When I visit the article page
    And I click "Delete article"
    Then I should be on the homepage
    And I should see 0 articles
    And I should see notice: "Article deleted"
