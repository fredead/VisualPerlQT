#$Id: Properties.pm,v 1.8 1998/05/18 16:37:21 simon Exp simon $

# simon
# Tue Mar 24 01:43:17 GMT 1998
# Properties package
#
#  This is to be inheritted by properties and allow a default
# functionality which will match most simple properties which
# can be overriden by the inheriting class. 
# simple whiys such as set value execute and gen code

# commands
# get_value()
# set_value(value)
# get_text()
# Exec_value(QObject)
# saving
# generating

package Properties;


sub new {
	my $class = shift;
	my $self = {};
	$self->{Title} = $_[0];
	$self->{Value} = $_[1];

	# In theory I should be able to write some genric
	# system to run a command ???
	$self->{Command} = $_[2];
	
	bless($self,$class);
	return $self;

}

sub get_value {
	my $self = shift;
	return $self->{Value};
}
	
sub set_value {
	my $self = shift;
	my $newvalue = shift;
	# There should be a way of checking this is a number
	# when it needs to be etc.
	$self->{Value} = $newvalue;
}

sub get_text {
	my $self = shift;
	return $self->{Title};
}

# Beta exec_value
sub exec_value {
	my $self = shift;	
	my $object = shift;
	my $thecmd = $self->{Command};
	eval { $object->$thecmd($self->{Value})};
}

sub saving {
	my $self = shift;
	#INSERT A SPACE TO DISTINGUSH THE VALUE FROM
	# OTHER PARTS OF SAVED FILE
	print " " . $self->{Value} . "\n";
}

sub generating {
	my $self = shift;
	my $varname = shift;
	
	print "\t\$" . $varname . "->";
	print $self->{Command} . "(\"" . $self->{Value} . "\");\n";
}

sub DESTROY {
}

# end properties
1;
