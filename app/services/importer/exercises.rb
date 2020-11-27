module Importer
  class Exercises < Importer::Base
    SUBJECT = 'exercises'.freeze

    private

    def process_row(row)
      exercise_params = row.to_h

      Exercise.create!(exercise_params)
    end

    def row_error_text(row, e)
      "Exercise for the following name can't be created: #{row['name']}. Error: #{e.message}"
    end
  end
end
