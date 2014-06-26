Feature: Create an article
  As an admin
  So that I can share content
  I want to create a new article

  Background:
    Given I am logged in

  Scenario: Visit the new article page
    Given I am on the homepage
    And I click "New Article"
    Then I should be on the new article page

  Scenario: Add a new article
    Given I am on the new article page
    And I add a new article
    Then I should be on the articles page
    And I should see the new article
