require_relative "../instapusher"
require 'net/http'
require 'uri'

module Instapusher
  class Commands

    attr_reader :debug, :api_key, :branch_name, :project_name, :staging, :local

    def initialize init_options
      @debug = init_options[:debug]
      @staging = init_options[:staging]
      @local = init_options[:local]
      @branch_name  = get_branch_name
      @project_name = get_project_name

      detect_api_key
    end

    def deploy
      verify_api_key
      #SpecialInstructionForProduction.new.run if production?

      job_submission = JobSubmission.new(debug, job_submission_parameters)
      job_submission.submit_the_job

      if job_submission.success?
        job_submission.feedback_to_user
        #TagTheRelease.new(branch_name, debug).tagit if (production? || staging?)
      else
        puts job_submission.error_message
      end
    end

    private

    def job_submission_parameters
        { project: project_name,
          local: local,
          branch:  branch_name,
          owner: repo_owner,
          version: VERSION,
          staging: staging,
          api_key: api_key }
    end

    def repo_owner
      Git.new.repo_owner
    end

    def verify_api_key

      if @api_key.to_s.length == 0
        puts ''
        abort "No instapusher API key was found. Please execute instapusher --api-key to setup instapusher API key."
      end
    end

    def detect_api_key
      @api_key = ENV['API_KEY'] || Instapusher::Configuration.api_key(debug) || ""
      log "api_key is #{@api_key}"
    end

    def production?
      branch_name.intern == :production
    end

    def staging?
      branch_name.intern == :staging
    end

    def log msg
      puts msg if debug
    end

    def get_branch_name
      ENV['INSTAPUSHER_BRANCH'] || git.current_branch
    end

    def get_project_name
      ENV['INSTAPUSHER_PROJECT'] || git.project_name
    end

    def git
      @_git ||= Git.new
    end

  end
end
