
# $Id: connclicked.pm,v 1.2 1998/05/18 16:38:20 simon Exp simon $
# simon Sat May  2 17:33:54 GMT 1998

# Clicked connection class
# class for a clicked connection

package connclicked;

use connection;

@ISA = qw{connection};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new('Clicked',$_[0],'clicked()');

	bless($self,$class);
	return($self);
}

