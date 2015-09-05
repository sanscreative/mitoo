@ECHO OFF
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo      Mirror tool version 1.0 release date 2015/09/05 
echo      ---------------------------------------------------
echo      Author Santosh Dwivedi santoshatsanscreativedotorg
echo      ---------------------------------------------------
echo      This program is distributed in the hope that it will be useful,
echo      but WITHOUT ANY WARRANTY; without even the implied warranty of
echo      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
echo      GNU General Public License for more details. 
echo      ----------------------------------------------------
echo      Usage: MirrorTool folderlist.txt  
echo      where folderlist.txt contains source and destination mapping
echo      e.g To mirror source directory to destination file has content
echo      -----------------------------------------------------
echo      C:\Users\destination=C:\Users\source   
echo      NOTE: multiple source and desination can be specified.  
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

SET FOLDERLIST=%1
if "FOLDERLIST"=="" goto :NOFILE
echo processing folder list file %FOLDERLIST%

REM List the entries
FOR /f "tokens=*" %%i IN (%FOLDERLIST%) DO @echo %%i

REM mirror every folder
FOR /f "tokens=*" %%i IN (%FOLDERLIST%) DO call :mirror "%%i"
goto :AllDone

:mirror 

REM echo processing   %1% ...

for /f "tokens=1-2 delims==" %%A in (%1%) do (
  echo Action: Mirroring "%%~B" to "%%~A"  
  if exist "%%~B" (
  robocopy "%%~B" "%%~A" /mir
  )else (  
   echo Error "%%~B" does not exists !
  )
)
goto :END
:NOFILE
echo Usage: mymirror folderlist.txt. Error no file specified!
pause

:AllDone
echo "Done..."
:END
