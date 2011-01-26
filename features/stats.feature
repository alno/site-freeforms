Feature: Stats page
  
  Scenario: See around
    When I go to the stats page
    Then I should see "Статистика использования сервиса"
    And I should see "Пользователи"
    And I should see "Формы"
    And I should see "Сообщения"
