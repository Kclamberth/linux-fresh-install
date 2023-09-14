#!/bin/bash

#Application list
app1=htop
app2=tldr
app3=lynis
app4=nmap
app5=wireshark
app6=steam
app7=discord
app8=macchanger
app9=vim
app10=flatpak
app11=iftop
app12=lutris
app13=yt-dlp

#Welcome message
echo "Welcome to KCL App installer!"
echo " "
sudo apt-get update >> kcl_pack_installer.log 2>&1

#App install
echo "Installing applications... (1/15)"
sudo apt-get install -y -q $app1 >> kcl_pack_installer.log 2>&1 #appends stderror AND stdout to log
e1=$?
echo "Installing applications... (2/15)"
sudo apt-get install -y -q $app2 >> kcl_pack_installer.log 2>&1
e2=$?
echo "Installing applications... (3/15)"
sudo apt-get install -y -q $app3 >> kcl_pack_installer.log 2>&1
e3=$?
echo "Installing applications... (4/15)"
sudo apt-get install -y -q $app4 >> kcl_pack_installer.log 2>&1
e4=$?
echo "Installing applications... (5/15)"
sudo apt-get install -y -q $app5 >> kcl_pack_installer.log 2>&1
e5=$?
echo "Installing applications... (6/15)"
sudo apt-get install -y -q $app6 >> kcl_pack_installer.log 2>&1
e6=$?
echo "Installing applications... (7/15)"
sudo apt-get install -y -q $app8 >> kcl_pack_installer.log 2>&1
e8=$?
echo "Installing applications... (8/15)"
sudo apt-get install -y -q $app9 >> kcl_pack_installer.log 2>&1
e9=$?
echo "Installing applications... (9/15)"
sudo apt-get install -y -q $app10 >> kcl_pack_installer.log 2>&1
e10=$?
echo "Installing applications... (10/15)"
sudo apt-get install -y -q $app11 >> kcl_pack_installer.log 2>&1
e11=$?

#flatpak applications
if [ $e10 -eq 0 ] #only execute if flatpak successfully installs
then
    echo "Installing applications... (11/15)"
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo >> kcl_pack_installer.log 2>&1
    
    echo "Installing applications... (12/15)"
    sudo flatpak install -y flathub com.ultimaker.cura >> kcl_pack_installer.log 2>&1
    ea=$?
    
    if [ $e6 -ne 0 ] #install steam via flatpak if not available in package manager
        then
        sudo flatpak install -y flathub com.valvesoftware.Steam >> kcl_pack_installer.log 2>&1
        eb=$?
    fi
    
    echo "Installing applications... (13/15)"
    sudo flatpak install -y flathub net.lutris.Lutris >> kcl_pack_installer.log 2>&1
    ec=$?
    
fi

#pull from discord site
echo "Installing applications... (14/15)"
wget -q "https://discord.com/api/download?platform=linux&format=deb" >> kcl_pack_installer.log 2>&1
sudo chmod +x 'download?platform=linux&format=deb' >> kcl_pack_installer.log 2>&1
sudo dpkg -i ~/'download?platform=linux&format=deb' >> kcl_pack_installer.log 2>&1
#e7 exit code moved to line 85

#pull from yt-dlp github page
echo "Installing applications... (15/15)"
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/bin/yt-dlp >> kcl_pack_installer.log 2>&1
e13=$?
sudo chmod a+rx /usr/bin/yt-dlp >> kcl_pack_installer.log 2>&1
sudo yt-dlp -U >> kcl_pack_installer.log 2>&1

echo "Installing applications... (DONE)"
sleep 3
echo " "

#fix dependencies 
echo "Fixing dependencies..."
sudo apt-get install -f -y >> kcl_pack_installer.log  2>&1 
e7=$? #required for discord to be successful
echo "Fixing dependencies... (DONE)"
sleep 3
echo " "

#exit codes & messages
if [ $e1 -eq 0 ]
then
    echo "$app1 successfully installed."
else
    echo "$app1 FAILED to install."
fi

if [ $e2 -eq 0 ]
then
    echo "$app2 successfully installed."
else
    echo "$app2 FAILED to install."
fi

if [ $e3 -eq 0 ]
then
    echo "$app3 successfully installed."
else
    echo "$app3 FAILED to install."
fi

if [ $e4 -eq 0 ]
then
    echo "$app4 successfully installed."
else
    echo "$app4 FAILED to install."
fi

if [ $e5 -eq 0 ]
then
    echo "$app5 successfully installed."
else
    echo "$app5 FAILED to install."
fi

if [ $e6 -eq 0 ] || [ $eb -eq 0 ] #steam via apt or flatpak
then
    echo "$app6 successfully installed."
else
    echo "$app6 FAILED to install."
fi

if [ $e7 -eq 0 ]
then
    echo "$app7 successfully installed."
else
    echo "$app7 FAILED to install."
fi

if [ $e8 -eq 0 ]
then
    echo "$app8 successfully installed."
else
    echo "$app8 FAILED to install."
fi

if [ $e9 -eq 0 ]
then
    echo "$app9 successfully installed."
else
    echo "$app9 FAILED to install."
fi

if [ $e10 -eq 0 ] #flatpak application checks
then
    echo "$app10 successfully installed."
    
    if [ $ea -eq 0 ]
    then
        echo "Ultimaker Cura successfully installed."
    else
        echo "Ultimaker Cura FAILED to install."
    fi

    if [ $ec -eq 0 ]
    then
        echo "$app12 successfully installed."
    else
        echo "$app12 FAILED to install."
    fi
else
    echo "$app10 FAILED to install."
fi

if [ $e11 -eq 0 ]
then
    echo "$app11 successfully installed."
else
    echo "$app11 FAILED to install."
fi

if [ $e12 -eq 0 ]
then
    echo "$app13 successfully installed."
else
    echo "$app13 FAILED to install."
fi

sleep 3
echo " "

#Trash cleanup
echo "Removing trash files..."
currentdirectory=$(pwd)
rm $currentdirectory/'download?platform=linux&format=deb'
echo "Removing trash files... (DONE)"

sleep 3
echo " "

echo "Finished installing applications."

