def what_web(port)
    puts "[+] Scaning - :[ whatweb ]: -> #{@target}:#{port}".green
    system("whatweb -v #{@target}:#{port} > ~/report/#{@project}/whatweb/what_web_report_#{port}.txt")
end

# not working yet
def web_headers(port)
    puts "[+] Scaning - :[ h2t.py ]: -> #{@target}"
    system(" python3 #{@user_path}/arsenal/recon/h2t/h2t.py s http://#{@target}:#{port} > ~/report/#{@project}/h2t/web_headers_#{port}.txt")
end


def dir_search(port)
    system("mkdir -p ~/report/#{@project}/dirb")
    
    puts "[+] Scaning - :[dirb]: -> #{@target}:#{port} Wordlist: #{@wordlist}".green
    system("dirb http://#{@target}:#{port} #{@wordlist} -o ~/report/#{@project}/dirb/dirb_#{port}_biglist.txt > /dev/null")
    puts ""
end

def web_recon(port)
	what_web(port)
	#web_headers(port)
    #ssl_scan(port)
    dir_search(port)
end

def web_ports_found
  @http_ports_array.map { |port| web_recon(port)}
end