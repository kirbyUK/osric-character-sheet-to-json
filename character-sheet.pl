#!/usr/bin/perl -w
use strict;
use JSON;

#Everything that needs to be on the character sheet:
my @stats = qw/
			name class alignment race 
			xp hp ac lvl 
			age height weight sex 
			gold
			/;

#And in single string form, seperated by '|' for
#the regex to use:
my $stats = join "|", @stats;

for my $character_sheet(@ARGV)
{
	unless(open my $file, '<', $character_sheet)
	{
		warn "Cannot open '$character_sheet': $!\n";
		next;
	}
	else
	{
		print "Reading '$character_sheet'...\n";
		my $char = { };
		for my $line(<$file>)
		{
			if($line =~ /^($stats):?\s*(.*)$/i)
			{
				my $attr = lc $1;
				$$char{$attr} = $2;
			}
		}
		error_check($char);
		write_character_to_file($char);
	}
}

#Checks for any issues and warns the user:
sub error_check
{
	my $char = shift;

	#Checks for any missing stats:
	my %similar;
	$similar{$_}++ for(@stats);
	$similar{$_}-- for(keys %$char);
	my @missing = grep { $similar{$_} != 0 } keys %similar;
	warn "\t(!) The following stats are missing: @missing\n" if(@missing);
}

#Writes the chracter hash to a JSON file:
sub write_character_to_file
{
	my $char = shift;
	my $filename = "$$char{name}.sheet";
	unless(open my $file, '>', $filename)
	{
		warn "Cannot open '$filename': $!\n";
		return 0;
	}
	else
	{
		print $file to_json($char, { pretty => 1 });
		print "Written '$filename'\n";
	}
}
