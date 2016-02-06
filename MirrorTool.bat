@ECHO OFF
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo      Mirror tool version 1.1 release date 2015/09/17 
echo      ---------------------------------------------------
echo      Author Santosh Dwivedi santosh(at)sanscreative(dot)org
echo      ---------------------------------------------------
echo      This program is distributed in the hope that it will be useful,
echo      but WITHOUT ANY WARRANTY; without even the implied warranty of
echo      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
echo      GNU General Public License for more details. 
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

SET FOLDERLIST=%1
SET ACTION="pull"
if "%2"=="push" SET ACTION="push"
if "%2"=="collect" SET ACTION="collect"
if "%2"=="collect" SET DSTFILEDIR="%3"
SET OPTION=/E
if "%3"=="--hard" SET OPTION=/mir
if "%FOLDERLIST%"=="" goto :NOFILE
set EXRTA_OPTIONS=
for /f "usebackq tokens=3*" %%i in (`echo %*`) DO @ set EXRTA_OPTIONS=%%j
echo processing folder list file %FOLDERLIST%

REM List the entries
FOR /f "tokens=*" %%i IN (%FOLDERLIST%) DO @echo %%i

REM mirror every folder
FOR /f "tokens=*" %%i IN (%FOLDERLIST%) DO call :mirror "%%i"
goto :AllDone

:mirror 

REM echo processing   %1% ...
if %ACTION%=="collect" (
  echo Action: Collecting files listed in   %1%  to directory  %DSTFILEDIR%
  for /f "delims=" %%i in (%1%) do copy "%%i" %DSTFILEDIR%
  goto :AllDone
)
for /f "tokens=1-2 delims==" %%A in (%1%) do (
  if %ACTION%=="pull" (
  echo Action: Mirroring "%%~B" to "%%~A"  
  if exist "%%~B" (
  robocopy "%%~B" "%%~A" %OPTION% %EXRTA_OPTIONS%
  )else (  
   echo Error "%%~B" does not exists !
  )
)
if %ACTION%=="push" (
  echo Action: Mirroring "%%~A" to "%%~B"  
  if exist "%%~A" (
  robocopy "%%~A" "%%~B" %OPTION% %EXRTA_OPTIONS%
  )else (  
   echo Error "%%~A" does not exists !
  )
)
)
goto :END
:NOFILE
echo      ***  Error no folderlist.txt file  specified!      ***
echo      --------------------------------------------------------
echo      Usage: MirrorTool folderlist.txt [push ,pull] [--hard| --soft ] [Extra options]
echo      ----------------------Examples:-------------------------
echo      Usage:
echo  MirrorTool folderlist.txt pull --hard pulls content from 
echo                                         remote to local creating 
echo                                         exact mirror, meaning local
echo                                         files not present on remote
echo                                         is deleted. 
echo  MirrorTool folderlist.txt pull  pushes only modified remote
echo                                  directory to local without
echo                                  deleting local files which
echo                                  are not presnet in remote.
echo  MirrorTool folderlist.txt       same as  MirrorTool.exe folderlist.txt pull
echo  MirrorTool folderlist.txt push --hard pushes local directory to remote
echo                                        to create exact mirror
echo  [Extra options] include  /XN  exclude Newer files, /XO exclude Older files. 
echo  MirrorTool folderlist.txt push  pushes only modified local directory to remote
echo  MirrorTool filelist.txt collect dircollect copies all files listed in filelist.txt to directory dircollect
echo      --------------------------------------------------------
echo      Where folderlist.txt contains local folder and remote mapping
echo      e.g To mirror "destination" directory to "source "file has content
echo      --------------------------------------------------------
echo      C:\Users\destination=C:\Users\source   
echo      NOTE: multiple source and desination can be specified.  
:AllDone
echo "Done..."
:END
