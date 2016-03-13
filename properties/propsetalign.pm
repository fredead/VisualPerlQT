
#$Id: propsetalign.pm,v 1.4 1998/05/18 16:44:08 simon Exp simon $
# simon
# Sat Apr 25 18:54:38 GMT 1998
# 
# Inherits from properties and sets up the values for
# set alignment property

package propsetalign;

use Properties;
# needs label to understand center and right ....
use QLabel;

@ISA = qw{Properties};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new('Setalign',$_[0],'setAlignment');

	bless($self,$class);
	return($self);
}

# exec the vaule require passing the $Align{ VALUE }
# in order to execute so is special
sub exec_value {
	my $self = shift;       
	my $object = shift;
	my $thecmd = $self->{Command};
	eval { $object->$thecmd($Align{$self->{Value}}) };
}

# generate the code for a specific variablename
sub generating {
	my $self = shift;
	my $varname = shift;
	print "\t\$" . $varname . "->";
	print $self->{Command} . "(\$Align{" . $self->{Value} . "});\n";
}

	
