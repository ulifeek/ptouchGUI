ptouchGUI

1. Purpose
PtouchGUI is used to print labels with Brother p-touch series label printers on Linux.
PtouchGUI is a graphical frontend for Dominik Rademacher's ptouch-print, written in Pascal (Lazarus).
Thanks to Dominik Rademacher, I really enjoy this program!
I could only test pt-2420pc, but PtouchGUi should support all printers that ptouch-print supports.

2. Compilation:
Prerequisites:
OS Linux 64bit (I used Kubuntu 22.04)
FPC/Lazarus (I used FPC 3.2.2/Lazarus 3.0RC1)

2. Installation
You can copy the binary to any directory. The program creates some subdirectories for data.
During execution, ptouchGUI requires a standard installation of ptouch-print. Ptouch-print should be able to run as a normal user (see link1 below).
You also need Imagemagick, especially Convert (workaround, see problems, link3).
You need to tell ptouchGUI the paths for printing and converting, probably ptouchGUI will ask you about it.
Last but not least, you have to select your printer (<Options> dialog) and edit the maximum ribbon length, DPI, supported ribbons and, if necessary, printable pixels of the ribbons.
There is no need to install a dedicated printer driver, ptouch-print controls the printer itself.

3. Usage
Modes:
- one line.
- multiple lines (one font).
- RTF (multi-line, different fonts and sizes possible).
- Graphics (There is no graphics editor, but you can create a template, edit it with an external program and import it again).

Printing:
- direct
- into a file
- into a queue

Queued printing saves files separately for each tape type. When you're done, you can print all the files of that tape type together.

4. Status and known issues
- This is a first test version with a very low version number. The program runs stable on my computer, but I cannot assume that it will also work on other computers. Feedback and suggestions are welcome
- ptouch-print requires monochrome images and I haven't managed to create and save these with Lazarus, which is probably due to limitations with Lazarus or GTK? Therefore using <convert> is a workaround))
- ptouch-print requires root rights to access USB functions. The best way is to set the SUID bit and assign it to the root user as described in Link2.

6. Links
Link1: https://dominic.familie-radermacher.ch/projekte/ptouch-print/
Link2: https://github.com/HenrikBengtsson/brother-ptouch-label-printer-on-linux
Link3: https://imagemagick.org/script/download.php


