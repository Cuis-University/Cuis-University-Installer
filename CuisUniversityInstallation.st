| newImageName |

CodePackageFile installPackage: '../Cuis-University/Cuis-University-Tests.pck.st' asFileEntry.

newImageName := Smalltalk imageName  asFileEntry name copyReplaceAll: 'Cuis5.0' with: 'CuisUniversity'.
Smalltalk  saveAs: newImageName andQuit: true embedded: false clearAllClassState: false
