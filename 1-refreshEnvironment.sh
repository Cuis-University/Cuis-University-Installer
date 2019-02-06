rm *.zip
rm *.tar.gz
rm Cuis5.0-*.image
rm Cuis5.0-*.changes
rm CuisUniversity*.image
rm CuisUniversity*.changes

rm -R linux32/Packages
rm -R linux64/Packages
rm -R windows32/Packages
rm -R windows64/Packages
rm -R macos64/Packages

rm -R linux32/Documentation
rm -R linux64/Documentation
rm -R windows32/Documentation
rm -R windows64/Documentation
rm -R macos64/Documentation

rm -R linux32/CoreUpdates
rm -R linux64/CoreUpdates
rm -R windows32/CoreUpdates
rm -R windows64/CoreUpdates
rm -R macos64/CoreUpdates

cd ../Cuis-Smalltalk-Dev
git pull
cp Cuis5.0-*.image ../Cuis-University-Installer
cp Cuis5.0-*.changes ../Cuis-University-Installer

cp -R Packages ../Cuis-University-Installer/linux32/Packages
cp -R Packages ../Cuis-University-Installer/linux64/Packages
cp -R Packages ../Cuis-University-Installer/windows32/Packages
cp -R Packages ../Cuis-University-Installer/windows64/Packages
cp -R Packages ../Cuis-University-Installer/macos64/Packages

cp ../Measures/Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Measures/Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Measures/Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Measures/Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Measures/Aconcagua/Aconcagua.pck.st ../Cuis-University-Installer/macos64/Packages

cp ../Calendars/Chalten/Chalten.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Calendars/Chalten/Chalten.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Calendars/Chalten/Chalten.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Calendars/Chalten/Chalten.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Calendars/Chalten/Chalten.pck.st ../Cuis-University-Installer/macos64/Packages

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
../Squeak.app/Contents/MacOS/Squeak InstallerBuilder.image -d 'CuisInstallerBuilder generateScriptsAndExit'
