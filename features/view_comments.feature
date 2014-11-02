Feature: View comments
  As a visitor
  In order see what other people have to say about an article
  I would like to read other's comments

  Scenario: View a comment
    Given there is an article with a comment
    And I am on the article page
    Then I should see the comment

  Scenario: See number of comments on articles index
    Given there is an article with 5 comments
    And I am on the articles page
    Then I should see "5 comments"
    
