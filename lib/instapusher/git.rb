module Instapusher

  class RepoOwnerIdentifierService

    attr_reader :string

    def initialize string
      @string = string
    end

    def process
      string.include?('git@github.com') ? handle_ssh_version : handle_https_version
    end

    private

    def handle_ssh_version
      regex = /.*:(.*)\/.*/
      match_data = string.match(regex)
      match_data.to_a.last
    end

    def handle_https_version
      regex = /.*:\/\/github\.com\/(.*)\/.*/
      match_data = string.match(regex)
      match_data.to_a.last
    end

  end

  class Git
    def current_branch
      result = %x{git branch}.split("\n")
      if result.empty?
        raise "It seems your app is not a git repository. Please check."
      else
        result.select { |b| b =~ /^\*/ }.first.split(" ").last.strip
      end
    end

    def current_user
      `git config user.name`.chop!
    end

    def project_name
      result = `git config remote.origin.url`.chop!.scan(/\/([^\/]+)?$/).flatten.first
      result.sub!(/\.git$/, '') if result
      result ||= File.basename(Dir.getwd)
      result
    end

    def repo_owner
      string = `git remote -v | grep fetch | grep origin`
      RepoOwnerIdentifierService.new(string).process
    end

  end
end

