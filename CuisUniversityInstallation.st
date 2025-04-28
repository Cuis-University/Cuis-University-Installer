| newImageName |

CodePackageFile installPackage: '../Cuis-University/CuisUniversity.pck.st' asFileEntry.
CodePackageFile installPackage: '../Cuis-Smalltalk-Refactoring/ExtraRefactoringsLiveTyping.pck.st' asFileEntry.
CodePackageFile installPackage: '../cuis-testlint/TestLint.pck.st' asFileEntry.
CodePackageFile installPackage: '../Cuis-Smalltalk-MethodFinder/MethodFinder.pck.st' asFileEntry.

newImageName := Smalltalk imageName asFileEntry name copyReplaceAll: 'Cuis7.3' with: 'CuisUniversity'.

Smalltalk saveAndQuitAs: newImageName clearAllClassState: false.
