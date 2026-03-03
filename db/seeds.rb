#require_relative 'languages/archived'
#require_relative 'languages/active'

#ActiveRecord::Base.transaction do
 # Language.unscoped.delete_all
 # @languages.each_with_index do |language, index|
 #   Language.create(
 #     id: language[:id],
 #     name: language[:name],
 #     is_archived: language[:is_archived],
 #     source_file: language[:source_file],
 #     compile_cmd: language[:compile_cmd],
 #     run_cmd: language[:run_cmd],
 #   )
 # end
#end
@languages = []

require_relative 'languages/archived'
require_relative 'languages/active'

ActiveRecord::Base.transaction do
  @languages.each do |language|
    Language.find_or_initialize_by(id: language[:id]).tap do |l|
      l.name = language[:name]
      l.is_archived = language[:is_archived]
      l.source_file = language[:source_file]
      l.compile_cmd = language[:compile_cmd]
      l.run_cmd = language[:run_cmd]
      l.save!
    end
  end
end
