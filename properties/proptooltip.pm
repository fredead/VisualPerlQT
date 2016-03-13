
#$Id: proptooltip.pm,v 1.1 1998/05/18 16:46:06 simon Exp simon $
# simon Thu May 14 22:08:33 GMT 1998
# 
# Inherits from properties and sets up the values for
#   a tooltip ???

package proptooltip;


use Properties;
use Qt;
use QColor;
use QToolTip;

@ISA = qw{Properties};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new('tooltip',$_[0],'QToolTip');

	bless($self,$class);
	return($self);
}

# set up a tooltip so it can be seen right away
sub exec_value {
	my $self = shift;       
	my $object = shift;
	my $thecmd = $self->{Command};
	eval { QToolTip::add($object, $self->{Value}) };
}

# generate the code for the output file
sub generating {
	my $self = shift;
	my $varname = shift;
	print "\t" . $self->{Command} . "::add(\$" . $varname;
	print ",'" . $self->{Value} . "');\n";
}

	
