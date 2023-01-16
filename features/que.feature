Feature: Errors are delivered to Bugsnag from Que

Scenario: Que will deliver unhandled errors
  Given I start the service "que"
  When I execute the command "bundle exec ruby app.rb unhandled" in the service "que"
  And I wait to receive an error
  Then the error is valid for the error reporting API version "4.0" for the "Ruby Bugsnag Notifier" notifier
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "severityReason.type" equals "unhandledExceptionMiddleware"
  And the event "severityReason.attributes.framework" equals "Que"
  And the event "app.type" equals "que"
  And the event "device.runtimeVersions.que" matches the current Que version
  And the exception "errorClass" equals "RuntimeError"

Scenario: Que will deliver handled errors
  Given I start the service "que"
  When I execute the command "bundle exec ruby app.rb handled" in the service "que"
  And I wait to receive an error
  Then the error is valid for the error reporting API version "4.0" for the "Ruby Bugsnag Notifier" notifier
  And the event "unhandled" is false
  And the event "severity" equals "warning"
  And the event "severityReason.type" equals "handledException"
  And the event "app.type" equals "que"
  And the event "device.runtimeVersions.que" matches the current Que version
  And the exception "errorClass" equals "RuntimeError"
