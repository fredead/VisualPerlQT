
# $Id: connection.pm,v 1.3 1998/05/18 16:39:07 simon Exp simon $
# simon Sat May  2 16:18:11 GMT 1998

# connection module 
# base class for all connection has defilat exec routine and
# generation routine
# Adds new get_slot command to return the name for the use slot bit

package connection;

use Properties;

@ISA = qw{Properties};

# Not possible to exec connections
sub exec_value {
}

sub get_slot {
	my $self = shift;
	print $self->{Value} . "(";
	# Get the variable tyep for the slot from the command
	# this means the user does not need to know about this :)
	if ( $self->{Command} =~ /.*\((.*)\)/ )
		{
		print $1;
		}
	print ")";
}


# Generate the connection line for the widget
sub generating{
	my $self = shift;
	my $varname = shift;
	
	# Connect to correct variable name
	print "\t\$self->connect(\$" . $varname . ",";
	print "'" . $self->{Command} . "','";
	print $self->{Value} . "(";

	# and work out variable type in command (shoudl
	# probably change in PerlQt Ver 2
	if ( $self->{Command} =~ /.*\((.*)\)/ )
		{
		print $1;
		}
	print ")');\n";
}

1;
