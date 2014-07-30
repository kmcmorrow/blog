Feature: Delete a comment
  As an admin
  In order to remove spam and bad comments
  I would like to delete a comment

  Scenario: Delete a comment
    Given there is an article with a comment
    And I am logged in
    And I visit the article page
    When I delete the comment
    Then I should be on the article page
    And I should not see the comment
