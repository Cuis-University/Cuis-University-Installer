| newName fullNewName fullChangesName |

Utilities classPool
	at: #AuthorInitials put: 'HAW';
	at: #AuthorName put: 'Hernan Wilkinson'.

ChangeSet installNewUpdates.

newName := Smalltalk filenameForUpdatedImage: true.
fullNewName := (DirectoryEntry smalltalkImageDirectory // newName) pathName.
fullChangesName := Smalltalk fullNameForChangesNamed: newName.

'../../Installer' asDirectoryEntry
  at: 'copy64ImageFromDev.sh'
  put:
    'mv ', fullNewName, ' .', String newLineString,
    'mv ', fullChangesName, ' .', String newLineString.

Smalltalk saveRollingReleaseAndQuit.
