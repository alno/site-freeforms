Feature: Forms

  Scenario: Logged in sees form
    Given I am logged in as "tester@mail.ru"
    When I go to the homepage
    Then I should see "Профиль"
    And I should see "Просмотреть форму"
    When I follow "Просмотреть форму"
    Then I should see "Описание"
    And I should see "Поля"
    And I should see "Код"
    
  Scenario: Logged in sees messages
    Given I am logged in as "tester@mail.ru"
    When I go to the homepage
    Then I should see "Профиль"
    And I should see "Сообщения"
    When I follow "Сообщения"
    Then I should see "Сообщения"
    
  Scenario: Logged in creates form
    Given I am logged in as "tester@mail.ru"
    And I am on the homepage
    When I follow "Создать новую форму"
    Then I should see "Новая форма"
    When I fill in "form[title]" with "My new form"
    And I press "Создать форму"
    Then I should see "Форма"
    And I should see "My new form"