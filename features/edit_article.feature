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
    And I should see the category link

  Scenario: Remove a category
    Given there is an article with 2 categories
    When I visit the edit article page
    And I unselect the first category
    And I click the "Update" button
    Then I should be on the article page
    And I should only see a link to the other category

  Scenario: Redirect back to last page when form is cancelled
    Given there is 1 published article
    And I am on the article page
    When I click "Edit article"
    And I click "Cancel"
    Then I should be on the article page

