VM_64=../Squeak.app/Contents/MacOS/Squeak
if [ -f "$VM_64" ]; then
    echo "64 VM Found"
else
    echo "64 VM does not exist. It should be at $VM_64"
    exit 1
fi

VM_32=../Squeak32.app/Contents/MacOS/Squeak
if [ -f "$VM_32" ]; then
  echo "32 VM Found"
else
    echo "32 VM does not exist. It should be at $VM_32"
    exit 1
fi

VM_LiveTyping=../SqueakLiveTyping.app/Contents/MacOS/Squeak
if [ -f "$VM_LiveTyping" ]; then
  echo "LiveTyping VM Found"
else
    echo "LiveTyping VM does not exist. It should be at $VM_LiveTyping"
    exit 1
fi

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

rm -R linux32/AdditionalFontData
rm -R linux64/AdditionalFontData
rm -R windows32/AdditionalFontData
rm -R windows64/AdditionalFontData
rm -R macos64/AdditionalFontData

cd ../Cuis-Smalltalk-Refactoring
git pull

# cd ../Cuis-Smalltalk-Refactorings-Thesis
# git pull

# cd ../TDDGuru
# git pull

cd ../Cuis-Smalltalk-Dev
git pull

cd ../Installer
../Squeak.app/Contents/MacOS/Squeak InstallerBuilder.image -d 'CuisInstallerBuilder generateUpdateImagesScriptAndExit'
chmod +x updateImages.sh
./updateImages.sh
chmod +x copy64ImageFromDev.sh
chmod +x copy32ImageFromDev.sh
./copy64ImageFromDev.sh
./copy32ImageFromDev.sh

cd ../Cuis-Smalltalk-Dev

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

cp ../LiveTyping/Smalltalk/LiveTyping.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../LiveTyping/Smalltalk/LiveTyping.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../LiveTyping/Smalltalk/LiveTyping.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../LiveTyping/Smalltalk/LiveTyping.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../LiveTyping/Smalltalk/LiveTyping.pck.st ../Cuis-University-Installer/macos64/Packages

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

cp ../TDDGuru/*.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../TDDGuru/*.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../TDDGuru/*.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../TDDGuru/*.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../TDDGuru/*.pck.st ../Cuis-University-Installer/macos64/Packages

cp ../Cuis-Smalltalk-Refactoring/*.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Cuis-Smalltalk-Refactoring/*.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Cuis-Smalltalk-Refactoring/*.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Cuis-Smalltalk-Refactoring/*.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Cuis-Smalltalk-Refactoring/*.pck.st ../Cuis-University-Installer/macos64/Packages

cp ../Cuis-Smalltalk-Refactorings-Thesis/*.pck.st ../Cuis-University-Installer/linux32/Packages
cp ../Cuis-Smalltalk-Refactorings-Thesis/*.pck.st ../Cuis-University-Installer/linux64/Packages
cp ../Cuis-Smalltalk-Refactorings-Thesis/*.pck.st ../Cuis-University-Installer/windows32/Packages
cp ../Cuis-Smalltalk-Refactorings-Thesis/*.pck.st ../Cuis-University-Installer/windows64/Packages
cp ../Cuis-Smalltalk-Refactorings-Thesis/*.pck.st ../Cuis-University-Installer/macos64/Packages

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

cp -R AdditionalFontData ../Cuis-University-Installer/linux32/AdditionalFontData
cp -R AdditionalFontData ../Cuis-University-Installer/linux64/AdditionalFontData
cp -R AdditionalFontData ../Cuis-University-Installer/windows32/AdditionalFontData
cp -R AdditionalFontData ../Cuis-University-Installer/windows64/AdditionalFontData
cp -R AdditionalFontData ../Cuis-University-Installer/macos64/AdditionalFontData

cd ../Cuis-University-Installer
../Squeak.app/Contents/MacOS/Squeak InstallerBuilder.image -d 'CuisInstallerBuilder generateScriptsAndExit'
chmod +x 2-build64Image.sh
chmod +x 3-build32Image.sh
chmod +x 4-zip.sh
