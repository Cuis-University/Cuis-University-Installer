| newImageName |

CodePackageFile installPackage: '../Cuis-University/CuisUniversity.pck.st' asFileEntry.

newImageName := Smalltalk imageName asFileEntry name copyReplaceAll: 'Cuis6.0' with: 'CuisUniversity'.

Smalltalk saveAndQuitAs: newImageName clearAllClassState: false.

