#!/usr/bin/env ruby

require 'getoptlong'
require_relative 'modules/recon_module'


class Automata
    include ReconModule

	def initialize
        @url_file=""
        @user_path=ENV['HOME']
        handleOptions
	end

	def handleOptions
		@opts = GetoptLong.new(
	      ['--help',    '-h', GetoptLong::NO_ARGUMENT],
          ['--target',  '-t', GetoptLong::REQUIRED_ARGUMENT],
          ['--file',    '-f', GetoptLong::REQUIRED_ARGUMENT],
	      ['--proxy',   '-p', GetoptLong::NO_ARGUMENT],
	      ['--id',      '-i', GetoptLong::REQUIRED_ARGUMENT],
          ['--recon',   '-r', GetoptLong::NO_ARGUMENT]
	    )

	    @optn = 0
	    @opts.each do |opt, arg|
		  @optn += 1
          case opt
          when '--help'
            help

          when '--id' # done
            @id=arg

          when '--file'
            @target_file = arg

          when '--target' # done
            @target = arg

          when '--proxy'
            @tor = true

          when '--recon'
            @recon = true

          when '--wordlist' # done
            @wlist = true
            @wordlist = args
          else
            usage
          end
		end
		usage if @optn == 0
	end

	# Show usage
	def usage
	    puts """./kitsunerb [-t <target>/-f <file> <OPTIONS>]
      example: ./kitsune -t https://TargetSite.com
      example: ./kitsune -t 10.10.10.10
      example: ./kitsune -t target.com
      """
	    exit 0
	end

	# Show help
	def help
		puts """Usage:
                #{$0} [ -u <url> <OPTIONS>]
                OPTIONS:
                    -h\t--help\tPrint this help
                """
		exit 0
	end

  def run
    unless @wlist
        @wordlist = `locate big.txt |grep wordlist |head -n 1`.chomp
        if @wordlist.empty?
            puts "[-] WARNING: no wordlist provided or found on the system"
        end
    end

    # Todo
    # identify the project type, to determine
    # what module to load and use.
    unless @tor
        network_recon
    end

  end

end
