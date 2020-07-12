

def nmap_recon
	puts "[+] Scaning - Basic Scan -> #{@target}".green
    system("/usr/bin/nmap -Pn -sV #{@target} -oA ~/report/#{@id}/nmap/basic_scan > /dev/null")

    # put ports into a string with commas
    open_ports = get_open_ports * ","

    puts "[+] Scaning - script Scan -> #{@target}".green
    system("/usr/bin/nmap -p#{open_ports} --script vuln,banner,default -A -sV #{@target} -oA ~/report/#{@id}/nmap/script_scan > /dev/null")

    nmap_output

    puts "[-] Nmap Done\n".green
 end

 def nmap_scripts_vulns
 	puts "[+] Vulnerabilities Found"
	check_ports
	puts "[-] Done!\n\n"
 end