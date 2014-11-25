module Instapusher
  class JobSubmission

    attr_reader :options, :debug, :job_status_url, :response_body

    DEFAULT_HOSTNAME = 'instapusher.com'

    def initialize debug, options
      @debug = debug
      @options = options

      log "options is #{options.inspect}"
    end

    def success?
      job_status_url && job_status_url != ""
    end

    def pre_submission_feedback_to_user
      log "url to hit: #{url_to_submit_job.inspect}"
      log "options being passed to the url: #{options.inspect}"
      log "connecting to #{url_to_submit_job} to send data"
    end

    def feedback_to_user
      puts 'The application will be deployed to: ' + response_body['heroku_app_url']
      puts 'Monitor the job status at: ' + job_status_url
      cmd = "open #{job_status_url}"
      `#{cmd}`
    end

    def error_message
      response_body['error']
    end

    def submit_the_job
      pre_submission_feedback_to_user

      response = Net::HTTP.post_form URI.parse(url_to_submit_job), options
      raw_body = response.body
      log "response raw body: #{raw_body}"

      @response_body  = ::JSON.parse(raw_body)
      log "JSON parsed response raw body: #{response_body.inspect}"
      @job_status_url = response_body['status_url']
    end

    def url_to_submit_job
      @url ||= begin
          hostname =  if options[:local]
                        "localhost:3000"
                      elsif options[:staging]
                        "instapusher.net"
                      else
                        ENV['INSTAPUSHER_HOST'] || DEFAULT_HOSTNAME
                      end
          protocol = use_ssl? ? 'https' : 'http'
          "#{protocol}://#{hostname}/api/v1/jobs.json"
      end
    end

    def use_ssl?
      !(ENV['INSTAPUSHER_HOST'] || options[:local])
    end

    def log msg
      puts msg if debug
    end

  end
end
