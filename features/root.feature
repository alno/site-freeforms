Feature: Root page

  Scenario: See around
    When I go to the homepage
    Then I should see button "Войти"
    And I should see "Получить код"
    And I should see "Получить свою форму"
    And I should see "Восстановить пароль"
    And I should see "о проекте"

  Scenario: About page
    Given I am on the homepage
    When I follow "о проекте"
    Then I should be on the about page

  Scenario: Logged in see around
    Given I am logged in as "tester@mail.ru"
    When I go to the homepage
    Then I should see "tester@mail.ru"
    And I should see "Мои формы"
    And I should see "Выйти"
