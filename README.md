# Dell-R410-fan-speed-controller-script
This is a script for Dell R410 rack server to tone down fans for homelab users.

Setup guide:
Put ".sh" files into script folder you want to. I am using unRAID v6, thus I have placed them under /boot/config/scripts/fans/
Manually edit your "go" file to have same edited lines as this git version has or copy git version to /boot/config/, if you had not made any changes to it yet.

The config folder is access-able via windows samba share, when you enable your unRAID USB-stick to be shared under samba temporarely.

How to: unRAID webgui --> main --> flash --> SMB Security Settings:Security --> Public --> Apply

Now you should have "unRAID server --> flash --> config" folder tree

