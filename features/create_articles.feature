Feature: Create an article
  As an admin
  So that I can share content
  I want to create a new article

  Scenario: Visit the new article page
    Given I am logged in
    And I am on the homepage
    And I click "Add Article"
    Then I should be on the new article page
    
    
