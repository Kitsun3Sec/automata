def ssl_scan
    puts "[+] Scaning - :[ ssltest ]: -> #{@target}"
    system("#{@user_path}/arsenal/recon/testssl.sh/testssl.sh -oL ~/report/#{@project}/testssl/ https://#{target}:#{port}")
end