# Add ! to the end of any test methods to only run those tests

require "test/unit/testcase"

module Test
  module Unit
    class TestCase
      class << self
        def suite_with_bang_methods
          suite_without_bang_methods.tap do |suite|
            bang_tests = suite.tests.select { |test| test.method_name =~ /!!/ }
            
            unless bang_tests.empty?
              suite.tests.delete_if { |test| !bang_tests.include?(test) }
              puts "\nWarning: Only running ! tests for #{name}\n\n"
            end
          end
        end
        
        alias_method_chain :suite, :bang_methods
      end
    end
  end
end
