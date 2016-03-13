
#$Id: propvarname.pm,v 1.2 1998/05/18 16:46:26 simon Exp simon $
# simon
# 
# 
# Inherits from properties and sets up the values for
# variable namer

package propvarname;

use Properties;

@ISA = qw{Properties};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new('VarName',$_[0],'');

	bless($self,$class);
	return($self);
}
	

sub exec_value {
	#Cant happen during designer
}

# generate the code ,requiers temporary name What happens if
# a varname is the same as a temp one ?/?
sub generating {
	my $self = shift;
	my $varname = shift;

	print "\t\$self->{" . $self->{Value} . "} = \$";
	print $varname . ";\n";
}
