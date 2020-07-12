require 'colorize'
require_relative 'modules'


module ReconModule

  def network_recon
    create_report_folders
    nmap_recon
    nmap_scripts_vulns

    # if check_web_ports
    #   web_ports_found
    # end
  end

  def create_report_folders
    system("mkdir -p ~/report/#{@id}/nmap")
    # system("mkdir -p ~/report/#{@id}/smb")
    # system("mkdir -p ~/report/#{@id}/whatweb")
    # system("mkdir -p ~/report/#{@id}/testssl")
    # system("mkdir -p ~/report/#{@id}/h2t")
  end

end
