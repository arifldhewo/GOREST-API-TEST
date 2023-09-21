Feature:
#  SCENARIO 1:Put user with valid id
  Scenario: Patch user valid id with valid body
    Given  Patch edit user with valid id 5180162 and body "users/Patch/PatchValidIdValidBody.json"
    When Send request patch edit user
    Then Status code 200
    And Validate JSON Schema "users/Patch/PatchValidIdValidBodySchema.json"
#  SCENARIO 2:Put user with invalid id
  Scenario Outline:Patch user invalid id with valid body
    Given Patch edit user with invalid id "<id>" and body "users/Patch/PatchInvalidIdValidBody.json"
    When Send request patch edit user
    Then Status code 404
    And Responses body message should be "Resource not found"
    And Validate JSON Schema "users/Patch/PatchInvalidIdValidBodySchema.json"
    Examples:
      | id            |
      | -1234         |
      | %&^*^         |
      | nay@gmail.com |
      | nayyyyy       |
#  SCENARIO 3:Put user valid id with invalid body
  Scenario Outline:Put user valid id with invalid body
    Given Patch edit user with valid id 5180162 and invalid body name "<name>" email "<email>" gender "<gender>" status "<status>"
    When Send request patch edit user
    Then Status code 422
    And Validate JSON Schema "users/Patch/PatchValidIdInvalidBodySchema.json"
    Examples:
      | name | email         | gender    | status   |
      | ney  | ney@gmail,com | female    | active   |
      | 1235 | ney@gmail.com | perempuan | inactive |
      | via  | ney@gmail.com | male      | aktif    |
#  SCENARIO 4:Patch user  invalid id with invalid body
  Scenario Outline: Put user invalid id with invalid body
    Given Patch edit user with invalid id "<id>" and invalid body name "<name>" email "<email>" gender "<gender>" status "<status>"
    When Send request patch edit user
    Then Status code 404
    And Responses body message should be "Resource not found"
    And Validate JSON Schema "users/Patch/PatchInvalidIdInvalidBodySchema.json"
    Examples:
      | id     | name |  | email         | gender    | status   |
      | -16531 | ney  |  | ney@gmail,com | female    | active   |
      | disa   | 1235 |  | ney@gmail.com | perempuan | inactive |
      | &%^%$$ | via  |  | ney@gmail.com | male      | aktif    |