Feature: Search
  As a visitor
  In order to find the article I am looking for
  I would like to search all articles for some keywords

  Scenario Outline: Search for an article title
    Given the following articles exist
      | title       | text              |
      | First Post  | Hello world       |
      | Second Post | Some content      |
      | Third Post  | Some more content |
    And I am on the search page
    When I search for <keyword> then I should see <titles>
    Examples:
      | keyword | titles                              |
      | First   | First Post                          |
      | Second  | Second Post                         |
      | Third   | Third Post                          |
      | Post    | First Post, Second Post, Third Post |
