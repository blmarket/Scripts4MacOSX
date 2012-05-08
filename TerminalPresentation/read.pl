#!/usr/bin/env perl

use strict;
use Data::Dumper;

@_ = <STDIN>;

my $keytoinsert = "LSUIPresentationMode";
my $valuetoinsert = "<integer>4</integer>";

my $level = 0;
my $prevkey;
foreach(@_)
{
    $level++ if /<dict>/ or /<array>/;
    if($level == 1)
    {
        if (/^(.*)<key>(.*)<\/key>/)
        {
            if($2 eq $keytoinsert)
            {
                die "already inserted $2";
            }
            if($2 gt $keytoinsert and $keytoinsert gt $prevkey)
            {
                print $1."<key>$keytoinsert</key>\n$1$valuetoinsert\n";
            }
            $prevkey = $2
        }
    }
    print $_;
    $level-- if /<\/dict>/ or /<\/array>/;
}


