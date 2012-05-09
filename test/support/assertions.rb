module Support
  module Assertions
    def assert_same_content(result, expected)
      assert expected.size == result.size, "the arrays doesn't have the same size"
      expected.each do |element|
        assert result.include?(element), "The array doesn't include '#{element}'."
      end
    end

    def assert_not(assertion)
      assert !assertion
    end
  end
end