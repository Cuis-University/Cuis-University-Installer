| newImageName |

[
(Delay forSeconds: 2) wait. 

Feature require: 'LiveTyping'.
Feature require: 'Aconcagua'.
Feature require: 'Chalten'.
Feature require: 'DenotativeObject'.
Feature require: 'SystemCategoryAutoSaving'.
Feature require: 'EnclosableChars'.
Feature require: 'CodeCoverage'.
Feature require: 'Tools-Finder'.
Feature require: 'TestLint'.
Feature require: 'MethodFinder'.
Feature require: 'ExtraRefactoringsLiveTyping'.
Feature require: 'Morphic-Widgets-Extras'.
Feature require: 'Theme-Themes'.
Feature require: 'Debugger-MethodCreation'.
Feature require: 'CuisUniversity'.
Feature require: 'WebClient'.

Utilities clearAuthor.
Smalltalk saveAndQuit.] fork.

newImageName := (Smalltalk filenameForUpdatedImage: true) copyReplaceAll: 'Cuis' with: 'CuisUniversity'.
Smalltalk saveAs: newImageName. 