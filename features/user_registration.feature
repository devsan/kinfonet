Feature: User Registration

  To register, guest goes to registration form and fills in email, password and password confirmation. After registration, user is automatically logged in.

Scenario: Reader registers successfully via register form
  Given I am a guest
  When I fill out registration form with valid data
  Then I should be registered
  And I should be logged in
