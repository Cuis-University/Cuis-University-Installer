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
rm Cuis6.0-*.image
rm Cuis6.0-*.changes
rm CuisUniversity*.image
rm CuisUniversity*.changes
rm TheCuisBook.pdf

rm -R -f linux32/Packages
rm -R -f linux64/Packages
rm -R -f windows32/Packages
rm -R -f windows64/Packages
rm -R -f macos64/Packages

rm -R -f linux32/Documentation
rm -R -f linux64/Documentation
rm -R -f windows32/Documentation
rm -R -f windows64/Documentation
rm -R -f macos64/Documentation

rm -R -f linux32/CoreUpdates
rm -R -f linux64/CoreUpdates
rm -R -f windows32/CoreUpdates
rm -R -f windows64/CoreUpdates
rm -R -f macos64/CoreUpdates

rm -R -f linux32/TrueTypeFonts
rm -R -f linux64/TrueTypeFonts
rm -R -f windows32/TrueTypeFonts
rm -R -f windows64/TrueTypeFonts
rm -R -f macos64/TrueTypeFonts

curl -L -o TheCuisBook.pdf https://github.com/Cuis-Smalltalk/TheCuisBook/releases/download/latestpdfbuild/TheCuisBook.pdf
cp TheCuisBook.pdf macos64
cp TheCuisBook.pdf linux64
cp TheCuisBook.pdf windows64
cp TheCuisBook.pdf linux32
cp TheCuisBook.pdf windows32

cd ../Cuis-University
git pull

cd ../LiveTyping
git pull

cd ../Cuis-Smalltalk-DenotativeObject
git pull

cd ../Cuis-Smalltalk-Refactoring
git pull

cd ../TDDGuru
git pull

cd ../cuis-finder
git pull

cd ../cuis-finder-asWidget
git pull

cd ../cuis-code-coverage
git pull

cd ../cuis-system-updater
git pull

cd ../SystemCategoryAutoSaving
git pull

cd ../cuis-move-instance-variable-refactoring
git pull

cd ../Cuis-Smalltalk-Dev
git pull

./pullAllRepos.sh
 
cd ../Installer
../Squeak.app/Contents/MacOS/Squeak InstallerBuilder.image -d 'CuisInstallerBuilder generateUpdateImagesScriptAndExit'
chmod +x updateImages.sh
./updateImages.sh
chmod +x copy64ImageFromDev.sh
chmod +x copy32ImageFromDev.sh
./copy64ImageFromDev.sh
./copy32ImageFromDev.sh

cd ../Cuis-Smalltalk-Dev

cp pullAllRepos.sh ../Cuis-University-Installer/linux32
cp pullAllRepos.sh ../Cuis-University-Installer/linux64
cp pullAllRepos.sh ../Cuis-University-Installer/windows32
cp pullAllRepos.sh ../Cuis-University-Installer/windows64
cp pullAllRepos.sh ../Cuis-University-Installer/macos64

cp clonePackageRepos.sh ../Cuis-University-Installer/linux32
cp clonePackageRepos.sh ../Cuis-University-Installer/linux64
cp clonePackageRepos.sh ../Cuis-University-Installer/windows32
cp clonePackageRepos.sh ../Cuis-University-Installer/windows64
cp clonePackageRepos.sh ../Cuis-University-Installer/macos64

cp -R Packages ../Cuis-University-Installer/linux32/Packages
cp -R Packages ../Cuis-University-Installer/linux64/Packages
cp -R Packages ../Cuis-University-Installer/windows32/Packages
cp -R Packages ../Cuis-University-Installer/windows64/Packages
cp -R Packages ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../Measures ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Measures ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Measures ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Measures ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Measures ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../Calendars ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Calendars ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Calendars ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Calendars ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Calendars ../Cuis-University-Installer/macos64/Packages

mkdir ../Cuis-University-Installer/linux32/Packages/LiveTyping
mkdir ../Cuis-University-Installer/linux64/Packages/LiveTyping
mkdir ../Cuis-University-Installer/windows32/Packages/LiveTyping
mkdir ../Cuis-University-Installer/windows64/Packages/LiveTyping
mkdir ../Cuis-University-Installer/macos64/Packages/LiveTyping

rsync -r --exclude '.git*' ../LiveTyping/Smalltalk/*.pck.st ../Cuis-University-Installer/linux32/Packages/LiveTyping
rsync -r --exclude '.git*' ../LiveTyping/Smalltalk/*.pck.st ../Cuis-University-Installer/linux64/Packages/LiveTyping
rsync -r --exclude '.git*' ../LiveTyping/Smalltalk/*.pck.st ../Cuis-University-Installer/windows32/Packages/LiveTyping
rsync -r --exclude '.git*' ../LiveTyping/Smalltalk/*.pck.st ../Cuis-University-Installer/windows64/Packages/LiveTyping
rsync -r --exclude '.git*' ../LiveTyping/Smalltalk/*.pck.st ../Cuis-University-Installer/macos64/Packages/LiveTyping

rsync -r --exclude '.git*' ../Cuis-Smalltalk-DenotativeObject ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Cuis-Smalltalk-DenotativeObject ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Cuis-Smalltalk-DenotativeObject ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Cuis-Smalltalk-DenotativeObject ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Cuis-Smalltalk-DenotativeObject ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../Cuis-Smalltalk-Refactoring ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Cuis-Smalltalk-Refactoring ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Cuis-Smalltalk-Refactoring ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Cuis-Smalltalk-Refactoring ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Cuis-Smalltalk-Refactoring ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../Cuis-University ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Cuis-University ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Cuis-University ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Cuis-University ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Cuis-University ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../TDDGuru ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../TDDGuru ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../TDDGuru ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../TDDGuru ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../TDDGuru ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../cuis-finder-asWidget ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../cuis-finder-asWidget ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../cuis-finder-asWidget ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../cuis-finder-asWidget ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../cuis-finder-asWidget ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../cuis-code-coverage ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../cuis-code-coverage ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../cuis-code-coverage ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../cuis-code-coverage ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../cuis-code-coverage ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../cuis-move-instance-variable-refactoring ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../cuis-move-instance-variable-refactoring ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../cuis-move-instance-variable-refactoring ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../cuis-move-instance-variable-refactoring ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../cuis-move-instance-variable-refactoring ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../cuis-system-updater ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../cuis-system-updater ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../cuis-system-updater ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../cuis-system-updater ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../cuis-system-updater ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../SystemCategoryAutoSaving ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../SystemCategoryAutoSaving ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../SystemCategoryAutoSaving ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../SystemCategoryAutoSaving ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../SystemCategoryAutoSaving ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../VectorGraphics ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../VectorGraphics ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../VectorGraphics ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../VectorGraphics ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../VectorGraphics ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../TheCuisBook ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../TheCuisBook ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../TheCuisBook ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../TheCuisBook ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../TheCuisBook ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../Numerics ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Numerics ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Numerics ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Numerics ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Numerics ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../Erudite ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Erudite ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Erudite ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Erudite ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Erudite ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../Games ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Games ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Games ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Games ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Games ../Cuis-University-Installer/macos64/Packages

rsync -r --exclude '.git*' ../Morphic ../Cuis-University-Installer/linux32/Packages
rsync -r --exclude '.git*' ../Morphic ../Cuis-University-Installer/linux64/Packages
rsync -r --exclude '.git*' ../Morphic ../Cuis-University-Installer/windows32/Packages
rsync -r --exclude '.git*' ../Morphic ../Cuis-University-Installer/windows64/Packages
rsync -r --exclude '.git*' ../Morphic ../Cuis-University-Installer/macos64/Packages

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

cp -R TrueTypeFonts ../Cuis-University-Installer/linux32/TrueTypeFonts
cp -R TrueTypeFonts ../Cuis-University-Installer/linux64/TrueTypeFonts
cp -R TrueTypeFonts ../Cuis-University-Installer/windows32/TrueTypeFonts
cp -R TrueTypeFonts ../Cuis-University-Installer/windows64/TrueTypeFonts
cp -R TrueTypeFonts ../Cuis-University-Installer/macos64/TrueTypeFonts

cd ../Cuis-University-Installer
../Squeak.app/Contents/MacOS/Squeak InstallerBuilder.image -d 'CuisInstallerBuilder generateScriptsAndExit'
chmod +x 2-build64Image.sh
chmod +x 3-build32Image.sh
chmod +x 4-zip.sh
