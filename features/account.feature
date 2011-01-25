Feature: Account

  Scenario: Signup
    Given I am on the homepage
    And I am on the register page
    When I fill in "account[email]" with "my@mail.ru"
    And I fill in "account[password]" with "mypass"
    And I press "account_submit"
    Then "my@mail.ru" should receive an email

    When "my@mail.ru" opens the email
    Then I should see "Ваш пароль" in the email body

  Scenario: Restore password
    Given I am registered in as "tester@mail.ru"
    When I go to the root page
    And I follow "Восстановить пароль"
    Then I should be on the restore page

    When I fill in "account_password[email]" with "tester@mail.ru"
    And I press "Восстановить пароль"
    Then I should see "Инструкции по восстановлению пароля высланы"
    And "tester@mail.ru" should receive an email

    When "tester@mail.ru" opens the email
    Then I should see "password" in the email body

    When I follow "password" in the email
    And I fill in "account_password[password]" with "New password"
    And I fill in "account_password[password_confirmation]" with "New password"
    And I press "Установить пароль"
    Then I should see "Пароль успешно изменен"
    And I should be able to login as "tester@mail.ru" with "New password"

  Scenario: Change password
    Given I am logged in as "tester@mail.ru"
    When I go to the homepage
    And I follow "tester@mail.ru"
    And I follow "Редактировать профиль"
    Then I should be on the edit account page

    When I fill in "account[password]" with "New password"
    And I fill in "account[password_confirmation]" with "New password"
    And I press "Сохранить"
    Then I should see "Аккаунт обновлен"
    And I should be able to login as "tester@mail.ru" with "New password"
