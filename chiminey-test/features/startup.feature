Feature: Starting up chiminey

Scenario: Get the login page for chiminey to make sure its started correctly.

  Given I go to "http://nginx/accounts/login"
  Then page title should be "Chiminey: Connecting Scientists to HPC, Cloud and Big Data"
