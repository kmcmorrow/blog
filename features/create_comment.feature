Feature: Comment on article
  As a visitor
  In order to leave feedback
  I would like to comment on an article

  Scenario: Add a comment
    Given there is 1 published article
    And I am on the article page
    When I fill in a comment
    And I press the "Add Comment" button
    Then I should be on the article page
    And I should see my comment

  Scenario: Try to add a blank comment
    Given there is 1 published article
    And I am on the article page
    When I press the "Add Comment" button
    Then I should be on the article page
    And I should see error: "Comment can't be blank"
