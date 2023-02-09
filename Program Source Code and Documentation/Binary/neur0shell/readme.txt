The following information supplements the NeuroShell 2 manual and
the NeuroShell2 Help Files. If you need assistance with any of the
technical issues outlined below, you may call Ward Systems Group at
(301) 662-7950. Have your serial number ready.

1. Some program changes or enhancements may have been made since the
 manual was printed. Please refer to the Program Changes section of
 the Help File (Select Index from the Help menu of any NeuroShell 2
 module) to find out what these changes are. If you are upgrading
 from an older release, please review the changes that have been made
 after your older release.

2. To install NeuroShell 2 on your system, you need to be running
 Windows 3.1 on an 80386 but obviously an 80486 is better. You will
 need about 4MB of RAM and about 8MB of hard disk space. You may later
 erase the examples in the EXAMPLES subdirectory of the NeuroShell 2
 directory if you are short on hard disk space. To install, run SETUP
 on the first diskette which is the one with the serial number on it.
 You can do this from the Program Manager or File Manager FILE/RUN
 menus or by finding SETUP with your File Manager and double clicking
 it.

3. On some systems with networks operating, the NeuroShell 2 SETUP
 program may not function because the network does not allow
 it access to the Windows directory. If that happens on your system,
 you should contact your network systems technicians who may install 
 NeuroShell 2 under DOS with the batch file DOSINST.BAT which is on
 diskette 1. Call it with 3 arguments: the name of the NeuroShell 2
 directory you want, the name of the directory where you want the 
 dynamic link libraries stored, and the path to the Windows main
 directory e.g.:
   A:
   DOSINST  C:\NSHELL2  C:\WINDOWS\SYSTEM  C:\WINDOWS

 To use DOSINST, make sure there is a copy of EXPAND.EXE in your
 Windows directory, and make sure it is dated after 3/10/92. If you
 don't have one, there is one on diskette 1. Note: switch to the floppy
 drive before typing DOSINST; do not type A:DOSINST...

 After installation is complete, put your NeuroShell 2 directory in
 the PATH in AUTOEXEC.BAT, move in WIN87EM.DLL (see #4 below), and
 add ns2.exe as a program item under Windows to create the icon.

 See #5 below for more info on the second argument of DOSINST.

4. Your NeuroShell 2 diskette #1 contains a recent copy of the
 Microsoft Windows floating point driver. The driver usually
 furnished with Windows 3.1 and usually dated 3/10/92 has bugs 
 in it and should be replaced with the newer one. Although
 Microsoft documentation states that the bugs only affect 387
 math coprocessors, we have noticed that the new driver positively
 affects results on 486/487 machines as well. It will not always
 install while Windows 3.1 is running, so you should copy this 
 file, called WIN87EM.DLL, to your Windows directory while Windows
 is down. Use the following DOS command while diskette #1 is in your
 A drive and assuming your Windows directory is WINDOWS:

   COPY  A:WIN87EM.DLL  C:\WINDOWS

 If WIN87EM.DLL is in your Windows System directory, then
 copy it there instead, replacing the old one. This information is
 repeated in the NeuroShell 2 help file. 

5. If you have Microsoft Visual Basic release 1 installed on your
 computer, there will be some conflict between some dynamic link
 libraries we supply, and those in Visual Basic release 1. Although
 Microsoft designed these libraries to be forward compatible, they
 were not in VB1. If you have trouble running VB1 after installing
 NeuroShell 2, we recommend that you upgrade to VB2 or later version.
 If you want to try to segregate the newer ones we supply from the
 older VB1 modules of the same name, you can tell NeuroShell 2
 setup to temporarily store the libraries in a directory other than
 the Windows System library. If you put them in your Windows library,
 they will not erase the old ones, and NeuroShell 2 will use them
 instead of the old ones in the Windows System directory. NeuroShell
 will not function properly if it uses the older libraries.

6. NeuroShell can be run with its Dynamic Link Libraries loaded
 somewhere other than the Windows or Windows System directories,
 but you have to know what you are doing. Windows looks for DLLs
 first in the current directory, next in the Windows directory,
 next in the Windows System directory, and last in the path set
 by the path statement. Remember that your current directory will
 change as you select data in different directories! 

 Note: If any previously installed programs installed their DLLs
 in \WINDOWS and they are the same as ours but with older dates,
 then you may have problems when ours are installed in the 
 \WINDOWS\SYSTEM directory. If you have any problems running 
 NeuroShell 2 (e.g., the error "Invalid Object Use") then check
 for the following DLLs in \WINDOWS:

  threed.vbx, spin.vbx, spread.vbx, gsw.exe, gswdll.dll, graph.vbx,
  grid.vbx, cmdialog.vbx

 If you suspect any problems then you can run our VBX Checker from
 the icon in the NeuroShell 2 Icon Group. This program will locate
 all applicable DLLs and even relocate them for you.


