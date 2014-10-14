Feature: Search
  As a visitor
  In order to find the article I am looking for
  I would like to search all articles for some keywords

  Background:
    Given the following articles exist
      | title       | text              |
      | First Post  | Hello world       |
      | Second Post | Some content      |
      | Third Post  | Some more content |

  Scenario Outline: Search for an article title
    Given I am on the search page
    When I search for "<keyword>"
    Then I should see link "<title>"
    Examples:
      | keyword | title       |
      | First   | First Post  |
      | Second  | Second Post |
      | Third   | Third Post  |
      | Post    | First Post  |
      | Post    | Second Post |
      | Post    | Third Post  |

  Scenario Outline: Search for article text
    Given I am on the search page
    When I search for "<keyword>"
    Then I should see link "<title>"
    Examples:
      | keyword | title       |
      | Hello   | First Post  |
      | content | Second Post |
      | content | Third Post  |

  Scenario: No results
    Given I am on the search page
    When I search for "Computer"
    Then I should see "No results"

  Scenario: Using the search box in the menu
    Given I am on the homepage
    Then I should see the search box
    When I search for a word in the sidebar
    Then I should be on the search page
    And I should see link "First Post"

  Scenario: Search link in nav bar
    Given I am on the homepage
    When I click "Search"
    Then I should be on the search page

  Scenario: Don't show draft articles in search results
    Given there is 1 unpublished article
    And I am on the search page
    When I search for the draft article
    Then I should see "No results"
