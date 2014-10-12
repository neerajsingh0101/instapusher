module Instapusher
  class TagTheRelease

    attr_reader :branch_name, :debug

    def initialize branch_name, debug
      @branch_name = branch_name
      @debug = debug
    end

    def tagit
      version_number = Time.current.to_s.parameterize
      tag_name = "#{branch_name}-#{version_number}"

      cmd = "git tag -a -m \"Version #{tag_name}\" #{tag_name}"
      puts cmd if debug
      system cmd

      cmd =  "git push --tags"
      puts cmd if debug
      system cmd
    end

  end
end
