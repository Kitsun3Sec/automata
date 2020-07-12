def nmap_output
  puts "PORT      STATE    SERVICE      VERSION"
  puts `/usr/bin/cat ~/report/#{@id}/nmap/basic_scan.nmap | grep open`
end

def smbmap_output
    result = `cat ~/report/#{@id}/smb/smbmap.txt |grep Permissions -A20 | grep -v "\\---" | grep -v Permissions | grep -v NO | grep -v Working | wc -l`
    result.split("\n").join.to_i

    if(result != 0)
      puts `cat ~/report/#{@id}/smb/smbmap.txt |grep Permissions -A20 | grep -v "\\---"`
    else
      puts "\t[-] NO Access without creds"
    end
    puts ""
end

def dirb_output
  puts `cat ~/report/#{@id}/dirb/dirb_#{@port}_biglist.txt | grep "==>"`
  puts ""
end

def eternal_blue
  state = `cat ~/report/#{@id}/nmap/script_scan.nmap | grep -A3 "smb-vuln-ms17-010" | grep "State: VULNERABLE" | cut -d ":" -f2 | sed 's/ //'`.chomp

  if (state == "VULNERABLE")
    puts "\t[+] 445 => ETERNALBLUE FOUND - CVE-2017-0143".red
  end
end

def rdp_dos
  state = `cat ~/report/#{@id}/nmap/script_scan.nmap | grep -A3 "rdp-vuln-ms12-020" | grep "State: VULNERABLE" | cut -d ":" -f2 | sed 's/ //'`.chomp

  if state == "VULNERABLE"
    puts "\t[+] 3389 => MS12-020 RDP DOS - CVE-2012-0152".red
  end
end

def rdp_rce
  state = `cat ~/report/#{@id}/nmap/script_scan.nmap | grep -A3 "MS12-020 Remote Desktop Protocol Remote Code Execution Vulnerability" | grep "State: VULNERABLE" | cut -d ":" -f2 | sed 's/ //'`.chomp

  if state == "VULNERABLE"
    puts "\t[+] 3389 => MS12-020 RDP RCE - CVE-2012-0002".red
  end
end