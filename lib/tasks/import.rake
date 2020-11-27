namespace :import do
  task exercises: :environment do
    desc 'Import exercises.'

    Importer::Exercises.call('exercises.csv')
  end
end
