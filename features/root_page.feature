Feature: Root page
  
  Scenario: See around
    When I go to the homepage
    Then I should see "Войти"
    And I should see "Зарегистрироваться"
    And I should see "Восстановить пароль"
    And I should see "О проекте"

  Scenario: About page
    Given I am on the homepage
    When I follow "О проекте"
    Then I should be on the about page
    And I should see title "О проекте"
    
  Scenario: Logged in see around
    Given I am logged in as "tester@mail.ru"
    When I go to the homepage
    Then I should see "Профиль"
    And I should see "Форма"
    And I should see "Выйти"
