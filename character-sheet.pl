#!/usr/bin/perl -w
use strict;
use JSON;

#Everything that needs to be on the character sheet:
my @stats = qw/
			Name Class Alignment Race 
			XP HP AC Lvl 
			Age Height Weight Sex 
			Gold
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
		write_character_to_file($char);
	}
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
