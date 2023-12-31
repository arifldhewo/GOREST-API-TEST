@GOREST
Feature: Get resources "posts" test cases
  @Positive
  Scenario: Get list posts normal flow
    Given Get list posts
    When Send request get list posts
    Then Status code 200

  @Positive
  Scenario: Get list posts normal flow with query string
    Given Get list posts with "1" as page and "1" as perpage
    When Send request get list posts
    Then Status code 200
    And Validate JSON Schema "posts/Get/GetListAllOfPostsJsonSchema.json"

  @Positive
  Scenario: Get list posts normal flow filter by user_id
    Given Get list posts filter by user_id
    When Send request get list posts by user_id
    Then Status code 200

  @Positive
  Scenario: Get single post normal flow
    Given Get single post by id "70220"
    When Send request get single posts
    Then Status code 200
    And Responses body should be "Vel numquam benigne damnatio certe coniuratio." as title and "Certo valetudo thalassinus. Spero torqueo amissio. Auxilium viscus catena. Apparatus laudantium est. Avarus condico astrum. Clarus creo aeneus. Vacuus congregatio desino. Calcar suggero fuga. Curis coma amitto. Teres delinquo utpote. Inflammatio clementia fugiat. Cumque artificiose spargo." as body
    And Validate JSON Schema "posts/Get/GetSingleUserPostsJsonSchema.json"

  @Negative
  Scenario Outline: Get single post with invalid data
    Given  Get single post by id "<id>"
    When Send request get single posts
    Then Status code <code>
    And Responses body should be "<msg>"
    And Validate JSON Schema "<schema>"
    Examples:
      | id         | code | schema                                             | msg                |
      | 91268123   | 404  | posts/Get/GetSingleUserPostsInvalidJsonSchema.json | Resource not found |
      | kasdkjlkas | 404  | posts/Get/GetSingleUserPostsInvalidJsonSchema.json | Resource not found |
      | *#^!@*#    | 404  | posts/Get/GetSingleUserPostsInvalidJsonSchema.json | Resource not found |