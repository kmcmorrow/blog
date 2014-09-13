Feature: Create categories
  As an admin
  In order to group articles
  I would like to create categories and assign articles to them

  Background:
    Given I am logged in

  Scenario: Create a new category
    Given I am on the categories page
    When I create a new category
    Then I should be on the categories page
    And I should see the new category

  Scenario: Create a category with existing name
    Given I am on the categories page
    When I create a new category with an existing name
    Then I should see the message: "Category already exists"

  Scenario Outline: Redirect back to last page when form is cancelled
    Given I am on the <page>
    And I click "New Category"
    When I click "Cancel"
    Then I should be on the <page>
      Examples:
        | page            |
        | homepage        |
        | articles page   |
        | categories page |

