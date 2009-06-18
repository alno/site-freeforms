Feature: Account
      
  Scenario: Signup
    Given I am on the homepage
    And I have email address "my@mail.ru"
    When I fill in "account[email]" with "my@mail.ru"
    And I fill in "account[password]" with "mypass"
    And I fill in "account[password_confirmation]" with "mypass"
    And I press "Зарегистрироваться"
    Then I should receive an email
    When I open the email
    Then I should see "activation" in the email
    When I follow "activation" in the email
    Then I should see "успешно активирован"
    
  Scenario: Restore password
    Given I am registered in as "tester@mail.ru"
    And I have email address "tester@mail.ru"
    When I go to the homepage
    And I fill in "account_password[email]" with "tester@mail.ru"
    And I press "Восстановить пароль"
    Then I should see "Инструкции по восстановлению пароля высланы"
    And I should receive an email
    When I open the email
    Then I should see "password" in the email
    When I follow "password" in the email
    And I fill in "account_password[password]" with "New password"
    And I fill in "account_password[password_confirmation]" with "New password"
    And I press "Установить пароль"
    Then I should see "Пароль успешно изменен"
    And I should be able to login as "tester@mail.ru" with "New password"
    
  Scenario: Change password
    Given I am logged in as "tester@mail.ru"
    When I go to the homepage
    And I follow "Мой профиль"
    And I follow "Редактировать профиль"
    Then I should be on the edit account page
    When I fill in "account[password]" with "New password"
    And I fill in "account[password_confirmation]" with "New password"
    And I press "Сохранить"
    Then I should see "Аккаунт обновлен"
    And I should be able to login as "tester@mail.ru" with "New password"