Utilities classPool
	at: #AuthorInitials put: 'HAW';
	at: #AuthorName put: 'Hernan Wilkinson'.

ChangeSet installNewUpdates.

[ (Delay forSeconds: 2) wait.
'../Installer' asDirectoryEntry
  at: ((Smalltalk imageName includesSubString: '-32.') ifTrue: [ 'copy32ImageFromDev.sh' ] ifFalse: [ 'copy64ImageFromDev.sh' ])
  put:
    'mv ', Smalltalk imageName, ' .', String newLineString,
    'mv ', Smalltalk defaultChangesName, ' .', String newLineString,
    'mv ', Smalltalk defaultUserChangesName, ' .'.

Smalltalk snapshot: true andQuit: true embedded: false clearAllClassState: false ] fork.

Smalltalk saveAsNewVersion.
