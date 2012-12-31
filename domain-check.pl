#!/usr/bin/env perl

print 'DomainCheck v2010.07.09 -- Copyright (c) 2010 Chris Olstrom';

my %config;
$config{'protocol'}	= 'https';		# For testing, use 'http'.
$config{'server'}	= 'reseller.enom.com';	# For testing, use 'resellertest.enom.com'.
$config{'api'}		= 'interface.asp';
$config{'user'}		= ''; # your username
$config{'password'}	= ''; # your password

## Parse arguments, build and execute API call.
my $DomainList = join(',',@ARGV);
my @sink = `curl -s $config{'protocol'}://$config{'server'}/$config{'api'} -d \'UID=$config{'user'}\' -d \'PW=$config{'password'}\' -d 'Command=Check' -d 'DomainList=$DomainList'`;

## Scrape the returned data for the requested information.
my (@domain,@status);
foreach my $record (@sink) {
	if ( $record =~ m/Domain(\d+)=(.+)\n/m ) {
		$domain[$1] = $2;
	}
	if ( $record =~ m/RRPText(\d+)=(.+)\n/m ){
		$status[$1] = $2;
	}
}

## Format everything and dump it to screen.
print "\nID\tDomain\t\t\tStatus";
print "\n--\t------\t\t\t------";
for (my $id = 1; $id <= scalar(@ARGV); $id++) {
	print "\n$id\t$domain[$id]\t\t\t\t$status[$id]";
}
print "\nDone checking ".scalar(@ARGV)." domains.\n";
