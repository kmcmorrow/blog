Feature: Edit an article
  As an admin
  In order to fix errors or update old content
  I want to be able to edit articles

  Scenario: Edit an article
    Given there is 1 published article
    And I am logged in
    When I visit the article page
    And I click the "Edit" link
    Then I should be on the edit article page
    When I fill in new article content
    And I click the "Update" button
    Then I should be on the article page
    And I should see the new article content

