require_relative '../db/vuln_db'

def get_open_ports
  `/usr/bin/cat ~/report/#{@id}/nmap/basic_scan.nmap | grep open | cut -d'/' -f1 | tr '\n' ' '`.split
end

def check_ports
  open_ports = get_open_ports.map(&:to_i)

  if open_ports.include?(21)
    @version = `cat ~/report/#{@id}/nmap/script_scan.nmap | grep "21/tcp   open  ftp" | awk '{print $4 " " $5}'` 
    #check_version
  end

  if open_ports.include?(445)
    eternal_blue
  end

  if open_ports.include?(3389)
    rdp_dos
    rdp_rce
  end

end

def check_web_ports
  @http_ports_array =`cat ~/report/#{@id}/nmap/basic_scan.nmap | grep ^"[0-9]" | grep http | awk '{print $1}'`.split.map(&:to_i)
  @http_ports_array.length > 0 ? true : false

end

# See how you did into glpi_scan
#def check_version
# vuln.each { |protocol,value|  
#end