def recon_smb
    puts "[+] Scaning - :[ smbmap ]: -> #{@target}".green
    system("#{@user_path}/arsenal/smbmap/smbmap.py -H //#{@target}/ > ~/report/#{@project}/smb/smbmap.txt")
    smbmap_output 
end