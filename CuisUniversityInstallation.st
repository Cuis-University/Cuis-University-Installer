| newImageName |

CodePackageFile installPackage: '../LiveTyping/Smalltalk/LiveTyping.pck.st' asFileEntry.
CodePackageFile installPackage: '../Measures/Aconcagua/Aconcagua.pck.st' asFileEntry.
CodePackageFile installPackage: '../Calendars/Chalten/Chalten.pck.st' asFileEntry.
CodePackageFile installPackage: '../DenotativeObject/DenotativeObject.pck.st' asFileEntry.
CodePackageFile installPackage: '../SystemCategoryAutoSaving/SystemCategoryAutoSaving.pck.st' asFileEntry.
CodePackageFile installPackage: '../cuis-pro-extras/EnclosableChars.pck.st' asFileEntry.
CodePackageFile installPackage: '../cuis-code-coverage/CodeCoverage.pck.st' asFileEntry.
CodePackageFile installPackage: '../cuis-finder-asWidget/Tools-Finder.pck.st' asFileEntry.
CodePackageFile installPackage: '../TDDGuru/TDDGuru.pck.st' asFileEntry.
CodePackageFile installPackage: '../cuis-testlint/TestLint.pck.st' asFileEntry.
CodePackageFile installPackage: '../Cuis-Smalltalk-MethodFinder/MethodFinder.pck.st' asFileEntry.
CodePackageFile installPackage: '../Cuis-Smalltalk-Refactoring/ExtraRefactoringsLiveTyping.pck.st' asFileEntry.
CodePackageFile installPackage: '../Morphic/Morphic-Widgets-Extras.pck.st' asFileEntry.
CodePackageFile installPackage: '../Cuis-Smalltalk-Dev/Packages/Theme-Themes.pck.st' asFileEntry.
CodePackageFile installPackage: '../Cuis-University/Debugger-MethodCreation.pck.st' asFileEntry.
CodePackageFile installPackage: '../Cuis-University/CuisUniversity.pck.st' asFileEntry.

newImageName := Smalltalk imageName asFileEntry name copyReplaceAll: 'Cuis7.5' with: 'CuisUniversity'.

Smalltalk saveAndQuitAs: newImageName clearAllClassState: false.
