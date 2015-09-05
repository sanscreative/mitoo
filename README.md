# mitoo
Mirror tool : A tool to help synchronize data content from remote directory or server to local directory on windows machine.
Mirrors list two folders from remote to local or vice versa.

Usage:
MirrorTool folderlist.txt pull --hard  // pulls content from remote to local deleting local files not present on remote to create exact mirror 
MirrorTool folderlist.txt pull         //pushes only modified remote directory to local.
MirrorTool folderlist.txt              // pulls content from remote to local without deleting local files not present on remote 
MirrorTool folderlist.txt push --hard  //pushes local directory to remote create exact mirror
MirrorTool folderlist.txt push         //pushes only modified local directory to remote.


folder list contains local and remote directories mapping seperated by = 
For example in folderlist.txt should have following format
c:\hello=d:\hello
c:\Users\guest=\\remote\guest
destinaton=source
local=remote
