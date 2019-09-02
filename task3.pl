use strict;
use warnings; 
use Term::ANSIScreen qw/:color /;
use Term::ANSIScreen qw(cls);
use Win32::Console::ANSI;
use Win32::Console;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use File::Copy qw(copy);
use String::HexConvert ':all';

my $CONSOLE=Win32::Console->new;
$CONSOLE->Title('Task 3 Keygen & Patcher');

my $clear_screen = cls(); 
my $osok = (colored ['bold green'], "OK");
my $osdanger = (colored ['bold red'], "DANGER");

############################################################


my $BwE = (colored ['bold blue'], qq{
===========================================================
|            __________          __________               |
|            \\______   \\ __  _  _\\_   ____/               |
|             |    |  _//  \\/ \\/  /|  __)_                |
|             |    |   \\\\        //       \\               |
|             |______  / \\__/\\__//______  /               |
|                    \\/IFN643 Task 3 Hax\\/                |
|        		                                  |
===========================================================\n});
print $BwE;

unless (-e "upx.exe") {
	print "\n$osdanger: You Require upx.exe in working directory (v3.94W+)! Aborting...\n"; 
	goto FAILURE;
} 

my %MD5_List;
my @MD5s = <*.exe>;
foreach my $MD5s (@MD5s) {
   open( my $exe, '<:raw', $MD5s );
	$MD5_List{(uc Digest::MD5->new->addfile($exe)->hexdigest)} = $MD5s ;
}

my $filename;
my $file;

if (exists $MD5_List{"BF6D08BB51F3E672A5B0EA0C3782E228"}) { #UPX Packed Version
$filename = $MD5_List{"BF6D08BB51F3E672A5B0EA0C3782E228"};
$file = substr($filename, 0, -4)."_unpacked.exe";

my $cmd = "upx.exe";
my @args = ($cmd, "-d","-o$file","$filename");
system (@args);

if ($? == -1 ) {
die "System failed to run @args: $?";
} 
}

unless (exists $MD5_List{"BF6D08BB51F3E672A5B0EA0C3782E228"}) {
	print "\n$osdanger: Syndicate Systems Level 3 Application Not Found! Aborting...\n"; 
	goto FAILURE;
} 

open(my $bin, "<", $file) or die $!; binmode $bin; #Open it in memory as $bin

print $clear_screen;
print $BwE;

print "\nFile: $file";

print "\n\n1. Patch";
print "\n2. Keygen";

print "\n\nMake your selection: ";

my $input = <STDIN>; chomp $input; 

if ($input eq "1") {

print $clear_screen;
print $BwE;

use Fcntl 'SEEK_SET';
my $fileminusexe = substr($file, 0, -4);
my $PatchedFile = $fileminusexe."_patched.exe"; copy $file, $PatchedFile;
open (my $PatchFile, '+<',$PatchedFile) or die $!; binmode($PatchFile);
my $patch = reverse pack "H*", 75;
sysseek $PatchFile, 0x12C6, SEEK_SET; syswrite ($PatchFile, $patch);
close ($PatchFile); 

print "\n$osok: File succesfully patched as $PatchedFile";

}

if ($input eq "2") {

Username:

print $clear_screen;
print $BwE;

print "\nEnter Username: ";
my $username = <STDIN>; chomp $username; 

if (length($username) < "7") {
	print "\nUsername must have a minimum 7 chars\n";
	while (<>) {
	chomp;
	last unless length;
	}
	goto Username;
	} else {

print "Your generated password is: ";

    foreach my $symbol (split //, $username){
        if ($symbol =~ /[A-Za-z]/){
            my $num = ord($symbol);
            $num += 8;

            if ($symbol =~ /^[A-Z]/){
                if ($num > ord('Z')){
                   $num -= 26;
                }
                elsif ($num < ord('A')){
                    $num += 26;
                }
            }
            elsif ($symbol=~ /^[a-z]/){
                if ($num > ord('z')){
                    $num -= 26;
                }
                elsif ($num < ord('a')){
                    $num += 26;
                }
            }
		
           print chr($num);
        }
        else{
            print $symbol;
        }
    }

}
}

if ($input ne "1" || "2") { goto FAILURE };

FAILURE:

print "\n\nPress Enter to Exit... ";
while (<>) {
chomp;
last unless length;
}