| newImageName |

CodePackageFile installPackage: '../Cuis-University/CuisUniversity.pck.st' asFileEntry.
CodePackageFile installPackage: '../cuis-testlint/TestLint.pck.st' asFileEntry.
CodePackageFile installPackage: '../cuis-move-instance-variable-refactoring/MoveInstanceVariableRefactoring.pck.st' asFileEntry.
CodePackageFile installPackage: '../move-method-refactoring/MoveMethodRefactoring.pck.st' asFileEntry.
CodePackageFile installPackage: '../cuis-extract-class-refactoring/ExtractClassRefactoring.pck.st' asFileEntry.

newImageName := Smalltalk imageName asFileEntry name copyReplaceAll: 'Cuis7.3' with: 'CuisUniversity'.

Smalltalk saveAndQuitAs: newImageName clearAllClassState: false.
