#!/usr/bin/perl -w
use strict;
use JSON;

foreach my $character_sheet(@ARGV)
{
	unless(open my $file, '<', $character_sheet)
	{
		warn "Cannot open '$character_sheet': $!\n";
		next;
	}
	else
	{
		my $char = { };
		foreach my $line(<$file>)
		{
			if($line =~ /^
						(Name|Class|Alignment|
						 Race|XP|HP|AC|Lvl|
						 Age|Height|Weight|Sex)
						:?
						\s*
						(.*)$
						/ix) {
				my $attr = lc $1;
				$$char{$attr} = $2;
			}
		}
		write_character_to_file($char);
	}
}

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
	}
}
