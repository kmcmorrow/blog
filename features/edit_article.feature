Feature: Edit an article
  As an admin
  In order to fix errors or update old content
  I want to be able to edit articles

  Background:
    Given I am logged in

  Scenario: Edit an article
    Given there is 1 published article
    When I visit the article page
    And I click the "Edit" link
    Then I should be on the edit article page
    When I fill in new article content
    And I click the "Update" button
    Then I should be on the article page
    And I should see the new article content

  Scenario: Add a category
    Given there is 1 published article
    And there is 1 category
    When I visit the edit article page
    And I select the category
    And I click the "Update" button
    Then I should be on the article page
    Then show me the page
    And I should see the category link

  Scenario: Remove a category
    Given there is an article with 1 category
    When I visit the edit article page
    And I deselect the category
    And I click the "Update" button
    Then I should be on the article page
    And I should not see the category link
