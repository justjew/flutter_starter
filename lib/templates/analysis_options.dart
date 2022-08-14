const String analysisOptionsText = '''include: package:flutter_lints/flutter.yaml

analyzer:
  plugins:
    - dart_code_metrics
  exclude:
    - "example/**"
    - "build/**"
    - "**/*.g.dart"
    - "**/*.freezed.dart"

dart_code_metrics: 
  metrics:
    cyclomatic-complexity: 10
    halstead-volume: 150
    lines-of-code: 200
    maintainability-index: 50
    maximum-nesting-level: 4
    number-of-methods: 10
    number-of-parameters: 3
    source-lines-of-code: 40
  metrics-exclude:
    - test/**
  rules:
    # Common rules
    - common/avoid-collection-methods-with-unrelated-types
    - common/avoid-duplicate-exports
    - common/avoid-global-state
    - common/avoid-late-keyword
    - common/avoid-missing-enum-constant-in-map
    - common/avoid-nested-conditional-expressions
    - common/avoid-non-null-assertion
    - common/avoid-throw-in-catch-block
    - common/avoid-unnecessary-type-assertions
    - common/avoid-unnecessary-type-casts
    - common/avoid-unrelated-type-assertions
    - common/avoid-unused-parameters
    - common/binary-expression-operand-order
    - member-ordering-extended:
        alphabetize: false
        order:
          - public-late-final-fields
          - private-late-final-fields
          - public-nullable-fields
          - private-nullable-fields
          - public-getters
          - private-getters
          - public-setters
          - private-setters
          - constructors
          - init-state-method
          - did-update-widget-method
          - did-change-dependencies-method
          - build-method
          - public-methods
          - private-methods
          - dispose-method
          - close-method
    - common/newline-before-return
    - common/no-boolean-literal-compare
    - common/no-empty-block
    - common/no-equal-then-else
    - common/no-magic-number
    - common/no-object-declaration
    - common/prefer-async-await
    - common/prefer-conditional-expressions
    - prefer-correct-identifier-length:
        exceptions: [ 'id', 'i', 'j' ]
        max-identifier-length: 30
        min-identifier-length: 3
    - common/prefer-correct-type-name
    - common/prefer-enums-by-name
    - common/prefer-first
    - common/prefer-immediate-return
    - common/prefer-last
    # - prefer-match-file-name:
    #     exclude:
    #       - test/**
    #       - lib/firebase_options.dart
    - common/prefer-trailing-comma
    - prefer-trailing-comma:
        break-on: 3

    # Flutter rules
    - flutter/always-remove-listener
    - flutter/avoid-border-all
    - flutter/avoid-returning-widgets
    - flutter/avoid-unnecessary-setstate
    - flutter/avoid-wrapping-in-padding
    - flutter/avoid-use-expanded-as-spacer
    - flutter/prefer-const-border-radius
    - flutter/prefer-correct-edge-insets-constructor
    - flutter/prefer-extracting-callbacks
    - flutter/prefer-single-widget-per-file
  rules-exclude:
    - test/**
  anti-patterns:
''';