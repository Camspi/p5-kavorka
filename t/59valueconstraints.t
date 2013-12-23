=pod

=encoding utf-8

=head1 PURPOSE

Check that value constraints work.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

use strict;
use warnings;
use Test::More;
use Test::Fatal;

use Kavorka;
use match::simple qw(match);

fun foo (Int $x where [2,4,6,8] = 2) {
	return $x;
}

fun bar (Int $x where { match $_, [2,4,6,8] } = 4) {
	return $x;
}

subtest "smartmatch-style value constraint" => fun
{
	is(foo(), 2);
	is(foo(8), 8);
	like(exception { foo(1.1) }, qr/^Value "?1\.1"? did not pass type constraint "?Int"?/);
	like(exception { foo(111) }, qr/^\$x failed value constraint/);
	done_testing;
};

subtest "block value constraint" => fun
{
	is(bar(), 4);
	is(bar(8), 8);
	like(exception { bar(1.1) }, qr/^Value "?1\.1"? did not pass type constraint "?Int"?/);
	like(exception { bar(111) }, qr/^\$x failed value constraint/);
	done_testing;
};

done_testing;