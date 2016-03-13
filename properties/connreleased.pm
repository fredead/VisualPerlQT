
# $Id: connreleased.pm,v 1.2 1998/05/18 16:40:01 simon Exp simon $
# simon Sat May  2 17:33:54 GMT 1998

# Released connection class

package connreleased;

use connection;

@ISA = qw{connection};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new('Released',$_[0],'released()');

	bless($self,$class);
	return($self);
}

