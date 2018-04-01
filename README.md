# Cuis-University-Installer
Scripts to generate CuisUniversity installer for all the platformw
# Image Building Steps
1) Run 1-refreshEnvironment.sh --> 
   a) removes all files used to create the previous installation (.zip, .tar.gz, Cuis5.0 image, etc).
   b) retrives latest version of Cuis5.0 from gitGub
   c) copies CoreUpdate, Documentation and Packages to each platform directory (linux32, linux64, etc)
   d) copies CuisUniversity packages to each platform Packages (Aconcagua, Chalten, etc)
   e) generates script 2 to 5 and run.xxx on each platform
2) Run 2-build64Image.sh --> creates 64 bits CuisUniverstiy image
3) Start a windows 32 VM and run 3-build32WinImage.bat --> creates windows 32 bits CuisUniversity image
3) Start a linux 32 VM and run 4-build32LinuxImage.sh --> creates linux 32 bits CuisUniversity image
4) Run 5-zip.sh --> create .zip and .tar.gz files for each platform
5) Upload new files to https://github.com/Cuis-University/Cuis-University/releases
# VM Update Steps
Updating the VMs is not automatized. It has to be done manually
