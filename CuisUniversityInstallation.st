| newImageName |

CodePackageFile installPackage: '../Cuis-University/CuisUniversity.pck.st' asFileEntry.

newImageName := Smalltalk imageName asFileEntry name copyReplaceAll: 'Cuis6.3' with: 'CuisUniversity'.

Smalltalk saveAndQuitAs: newImageName clearAllClassState: false.

