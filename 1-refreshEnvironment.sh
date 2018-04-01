rm *.zip
rm *.tar.gz
rm Cuis5.0-*.image
rm Cuis5.0-*.changes
rm CuisUniversity*.image
rm CuisUniversity*.changes
cd ../Cuis-Smalltalk-Dev
git pull
cp Cuis5.0-*.image ../Cuis-University-Installer
cp Cuis5.0-*.changes ../Cuis-University-Installer

cp -R Packages ../Cuis-University-Installer/linux32/Packages
cp -R Packages ../Cuis-University-Installer/linux64/Packages
cp -R Packages ../Cuis-University-Installer/windows32/Packages
cp -R Packages ../Cuis-University-Installer/windows64/Packages
cp -R Packages ../Cuis-University-Installer/macos64/Packages

cp ../Cuis-Smalltalk-Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Cuis-Smalltalk-Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Cuis-Smalltalk-Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Cuis-Smalltalk-Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Cuis-Smalltalk-Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/macos64/Packages

cp ../Cuis-Smalltalk-Chalten/Chalten.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Cuis-Smalltalk-Chalten/Chalten.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Cuis-Smalltalk-Chalten/Chalten.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Cuis-Smalltalk-Chalten/Chalten.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Cuis-Smalltalk-Chalten/Chalten.pck.st ../Cuis-University-Installer/macos64/Packages

cp ../Cuis-Smalltalk-DenotativeObject/DenotativeObject.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Cuis-Smalltalk-DenotativeObject/DenotativeObject.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Cuis-Smalltalk-DenotativeObject/DenotativeObject.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Cuis-Smalltalk-DenotativeObject/DenotativeObject.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Cuis-Smalltalk-DenotativeObject/DenotativeObject.pck.st ../Cuis-University-Installer/macos64/Packages

cp ../Cuis-Smalltalk-Refactoring/Refactoring.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Cuis-Smalltalk-Refactoring/Refactoring.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Cuis-Smalltalk-Refactoring/Refactoring.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Cuis-Smalltalk-Refactoring/Refactoring.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Cuis-Smalltalk-Refactoring/Refactoring.pck.st ../Cuis-University-Installer/macos64/Packages

cp ../Cuis-University/Cuis-University-Model.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Cuis-University/Cuis-University-Model.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Cuis-University/Cuis-University-Model.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Cuis-University/Cuis-University-Model.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Cuis-University/Cuis-University-Model.pck.st ../Cuis-University-Installer/macos64/Packages

cp ../Cuis-University/Cuis-University-Tests.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Cuis-University/Cuis-University-Tests.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Cuis-University/Cuis-University-Tests.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Cuis-University/Cuis-University-Tests.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Cuis-University/Cuis-University-Tests.pck.st ../Cuis-University-Installer/macos64/Packages

cp -R Documentation ../Cuis-University-Installer/linux32/Documentation
cp -R Documentation ../Cuis-University-Installer/linux64/Documentation
cp -R Documentation ../Cuis-University-Installer/windows32/Documentation
cp -R Documentation ../Cuis-University-Installer/windows64/Documentation
cp -R Documentation ../Cuis-University-Installer/macos64/Documentation

cp -R CoreUpdates ../Cuis-University-Installer/linux32/CoreUpdates
cp -R CoreUpdates ../Cuis-University-Installer/linux64/CoreUpdates
cp -R CoreUpdates ../Cuis-University-Installer/windows32/CoreUpdates
cp -R CoreUpdates ../Cuis-University-Installer/windows64/CoreUpdates
cp -R CoreUpdates ../Cuis-University-Installer/macos64/CoreUpdates

cd ../Cuis-University-Installer
../CocoaFast64.app/Contents/MacOS/Squeak InstallerBuilder.image -d 'CuisInstallerBuilder generateScriptsAndExit'
