
#$Id: propsetext.pm,v 1.2 1998/05/18 16:45:50 simon Exp simon $
# simon
# Wed Mar 25 01:21:57 GMT 1998
# 
# Inherits from properties and sets up the values for
# a set text property ??

package propsetext;

use Properties;

@ISA = qw{Properties};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new('Text',$_[0],'setText');

	bless($self,$class);
	return($self);
}
	
# requires no special functions as properties already hold default 
# function which works for this property (Is this the oly one ?)
