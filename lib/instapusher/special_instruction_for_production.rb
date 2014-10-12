module Instapusher
  class SpecialInstructionForProduction

    def run
      question = "You are deploying to production. Did you take backup? If not then execute rake handy:heroku:backup_production and then come back. "
      STDOUT.puts question
      STDOUT.puts "Answer 'yes' or 'no' "
      
      input = STDIN.gets.chomp.downcase

      if %w(yes y).include?(input)
        #do nothing
      elsif %w(no n).include?(input)
        abort "Please try again when you have taken the backup"
      else
        abort "Please answer yes or no"
      end
    end

  end
end
