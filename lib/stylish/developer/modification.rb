module Stylish
  module Developer

    # Handles a request to modify an asset that belongs to
    # a Stylish package.
    class Modification
      attr_reader :actual_path, :request

      def initialize(actual_path, request)
        @actual_path  = actual_path
        @request      = request
      end

    end
  end
end
