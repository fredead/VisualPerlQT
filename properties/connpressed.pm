
# $Id: connpressed.pm,v 1.2 1998/05/18 16:39:40 simon Exp simon $
# simon Sat May  2 17:33:54 GMT 1998

# Pressed connection class
# class for the connection pressed

package connpressed;

use connection;

@ISA = qw{connection};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new('Pressed',$_[0],'pressed()');

	bless($self,$class);
	return($self);
}

