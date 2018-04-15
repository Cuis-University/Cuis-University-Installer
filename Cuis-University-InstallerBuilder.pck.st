'From Cuis 5.0 of 7 November 2016 [latest update: #3285] on 15 April 2018 at 8:25:42 pm'!
'Description Script generation takes cares about windows commands'!
!provides: 'Cuis-University-InstallerBuilder' 1 2!
SystemOrganization addCategory: #'Cuis-University-InstallerBuilder'!


!classDefinition: #CuisInstallerBuilder category: #'Cuis-University-InstallerBuilder'!
Object subclass: #CuisInstallerBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-InstallerBuilder'!
!classDefinition: 'CuisInstallerBuilder class' category: #'Cuis-University-InstallerBuilder'!
CuisInstallerBuilder class
	instanceVariableNames: ''!


!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 3/31/2018 15:42:24'!
cuisSmalltalkDevDirName
	
	^'../Cuis-Smalltalk-Dev'! !

!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 4/15/2018 20:02:31'!
cuisVersionNumber

	| cuisSmalltalkDevDir fileNames imageName versionNumber |
	
	cuisSmalltalkDevDir := self cuisSmalltalkDevDirName asDirectoryEntry.
	fileNames := (cuisSmalltalkDevDir fileNamesMatching: 'Cuis5.0-*.image') asSortedCollection: [:fileNameLeft :fileNameRight | fileNameLeft size < fileNameRight size ].
	fileNames isEmpty ifTrue: [ self error: 'Image file not found' ].
	
	imageName := fileNames first.
	versionNumber := imageName copyFrom: 'Cuis5.0-' size + 1 to: (imageName indexOfSubCollection: '.image' startingAt: 1) - 1.
	
	^versionNumber ! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 4/1/2018 00:39:48'!
generate32LinuxBitImageBuilderScriptWith: versionNumber

	"self generate32LinuxBitImageBuilderScriptWith: '3283'"
	
	self 
		generate: '4-build32LinuxImage.sh' 
		vmPath: 'linux32/vm/squeak' 
		imageNameTail: '-V3' 
		platforms: #('linux32') 
		pathSeparator: '/' 
		with: versionNumber
! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 4/1/2018 00:41:13'!
generate32WinBitImageBuilderScriptWith: versionNumber

	"self generate32WinBitImageBuilderScriptWith: '3283'"
	
	self 
		generate: '3-build32WinImage.bat' 
		vmPath: 'windows32\vm\Squeak' 
		imageNameTail: '-32' 
		platforms: #('windows32') 
		pathSeparator: '\' 
		with: versionNumber
	! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 4/1/2018 00:42:13'!
generate64BitImageBuilderScriptWith: versionNumber

	"self generate64BitImageBuilderScriptWith: '3283'"
	
	self 
		generate: '2-build64Image.sh' 
		vmPath: '../CocoaFast64.app/Contents/MacOS/Squeak' 
		imageNameTail: '' 
		platforms: #('macos64' 'linux64' 'windows64') 
		pathSeparator: '/' 
		with: versionNumber
		! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 4/1/2018 00:18:09'!
generateRunScriptsWith: versionNumber

	self generateWindow64RunScriptWith: versionNumber.
	self generateWindow32RunScriptWith: versionNumber.
	self generateLinux64RunScriptWith: versionNumber.
	self generateLinux32RunScriptWith: versionNumber.
	self generateMacOs64RunScriptWith: versionNumber.
	
	! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 4/1/2018 00:49:02'!
generateScripts

	"self generateScripts"
	
	| versionNumber |
	
	versionNumber := self cuisVersionNumber.
	
	self 
		generate64BitImageBuilderScriptWith: versionNumber;
		generate32WinBitImageBuilderScriptWith: versionNumber;
		generate32LinuxBitImageBuilderScriptWith: versionNumber;
		generateRunScriptsWith: versionNumber;
		generateZipScript
! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/31/2018 12:51:34'!
generateScriptsAndExit

	self generateScripts.
	Smalltalk snapshot: true andQuit: true! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/31/2018 15:46:34'!
generateZipScript	
	
	| fileStream  |
		
	fileStream := FileStream concreteStream new 
		open: '/Users/hernan/Documents/Cuis/5.0-64Bits/Cuis-University-Installer/5-zip.sh' 
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create zip script file' ].

	[ fileStream
		truncate;
		nextPutAll: 'zip -r macos64 macos64';
		newLine;
		nextPutAll: 'zip -r windows64 windows64';
		newLine;
		nextPutAll: 'zip -r windows32 windows32';
		newLine;
		nextPutAll: 'tar czf linux64.tar.gz linux64';
		newLine;
		nextPutAll: 'tar czf linux32.tar.gz linux32' ] ensure: [ fileStream close ].
				

! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 4/15/2018 20:25:09'!
addCopyImageTo: fileStream on: osDir imageNameTail: tail pathSeparator: pathSeparator with: versionNumber

	fileStream 
		newLine;
		nextPutAll: (pathSeparator = '/' ifTrue: [ 'rm '] ifFalse: [ 'del ' ]);
		nextPutAll: osDir;
		nextPutAll: pathSeparator;
		nextPutAll: '*.image';
		newLine;
		nextPutAll: (pathSeparator = '/' ifTrue: [ 'rm '] ifFalse: [ 'del ' ]);
		nextPutAll: osDir;
		nextPutAll: pathSeparator;
		nextPutAll: '*.changes';
		newLine;
		nextPutAll: (pathSeparator = '/' ifTrue: [ 'cp'] ifFalse: [ 'copy' ]);
		nextPutAll: ' CuisUniversity-';
		nextPutAll: versionNumber;
		nextPutAll: tail;
		nextPutAll: '.* ';
		nextPutAll: osDir ! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 4/1/2018 00:34:23'!
addCuisUniversityInstallationTo: fileStream vmPath: vmPath imageNameTail: tail with: versionNumber

	fileStream
		nextPutAll: vmPath;
		nextPutAll: ' Cuis5.0-';
		nextPutAll: versionNumber;
		nextPutAll: tail;
		nextPutAll: '.image -s CuisUniversityInstallation.st'.! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 4/1/2018 00:44:37'!
generate: scriptName vmPath: vmPath imageNameTail: tail platforms: platforms pathSeparator: pathSeparator with: versionNumber

	"self generate: '4-build32LinuxImage.sh' vmPath: 'linux32/vm/squeak' imageNameTail: '-V3' platforms: #('linux32') pathSeparator: '/' with: '3283'"
	
	| fileStream  |
		
	fileStream := FileStream concreteStream new 
		open:  '/Users/hernan/Documents/Cuis/5.0-64Bits/Cuis-University-Installer/', scriptName 
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create ', scriptName ].

	[ fileStream truncate. 
	self addCuisUniversityInstallationTo: fileStream vmPath: vmPath imageNameTail: tail with: versionNumber.
	platforms do: [ :osDir | self addCopyImageTo: fileStream on: osDir imageNameTail: tail pathSeparator: pathSeparator with: versionNumber]
	] ensure: [ fileStream close ].

	! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 4/1/2018 00:53:18'!
generateRunScript: scriptFileName vmPath: vmPath imageNameTail: tail with: versionNumber
	
	"self generateRunScript: macos64/run.sh' vmPath: 'CocoaFast64.app/Contents/MacOS/Squeak' imageNameTail: '' with: '32'"
	
	| fileStream |
	
	fileStream := FileStream concreteStream new 
		open: '/Users/hernan/Documents/Cuis/5.0-64Bits/Cuis-University-Installer/', scriptFileName  
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create ', scriptFileName ].

	[ fileStream truncate.
	(scriptFileName endsWith: '.sh') ifTrue: [
		fileStream 
			nextPutAll: '#!!/bin/bash';
			newLine ].
	fileStream 
		nextPutAll: vmPath;
		nextPutAll: ' CuisUniversity-';
		nextPutAll: versionNumber;
		nextPutAll: tail;
		nextPutAll: '.image' ] ensure: [ fileStream close ].



				

! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:56:23'!
generateLinux32RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'linux32/run.sh'
		vmPath: 'vm/squeak'
		imageNameTail: '-V3'
		with: versionNumber! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:54:55'!
generateLinux64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'linux64/run.sh'
		vmPath: 'vm/squeak'
		imageNameTail: ''
		with: versionNumber
		
	! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:54:17'!
generateMacOs64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'macos64/run.sh'
		vmPath: 'CocoaFast64.app/Contents/MacOS/Squeak'
		imageNameTail: ''
		with: versionNumber! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:55:55'!
generateWindow32RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'windows32/run.bat'
		vmPath: 'vm\squeak'
		imageNameTail: '-32'
		with: versionNumber
	
	! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:55:27'!
generateWindow64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'windows64/run.bat'
		vmPath: 'vm\squeak'
		imageNameTail: ''
		with: versionNumber
! !
