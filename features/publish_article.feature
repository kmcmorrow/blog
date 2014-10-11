Feature: Draft and publish articles
  As an admin
  In order to make articles visible
  I would like set an articles status to published

  Background:
    Given I am logged in

  Scenario: Create a draft article
    Given I am on the new article page
    When I create a new article with draft chosen
    Then I should be on the article page
    And I should see the text "DRAFT"

  Scenario: Create a published article
    Given I am on the new article page
    When I create a new article with published chosen
    Then I should be on the article page
    And I should see the text "PUBLISHED"

  Scenario: Publish a draft article from the article page
    Given there is 1 unpublished article
    And I am on the article page
    Then I should see the text "DRAFT"
    When I click "Publish"
    Then I should see the text "PUBLISHED"

  Scenario: Publish a draft article from the index page
    Given there is 1 unpublished article
    And I am on the articles page
    When I click "Publish"
    Then I should be on the articles page
    Then I should see the text "PUBLISHED"
