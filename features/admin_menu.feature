Feature: Admin menu
  As an admin
  In order to easily administrate the site
  I should see a menu with links to common actions

  Scenario: View the admin menu
    Given I am logged in
    And I am on the homepage
    Then I should see the admin menu
    And it should contain these links:
      | New Article  |
      | New Category |

  Scenario: Only visible to admin
    Given I am on the homepage
    Then I should not see the admin menu
