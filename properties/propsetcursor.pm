
#$Id: propsetcursor.pm,v 1.4 1998/05/18 16:44:30 simon Exp simon $
# simon
# Sat Apr 11 12:57:42 GMT 1998
# 
# Set cursor property shoudl use names form default X cursor list
# and maybe support bitmaps
package propsetcursor;

use Properties;
use QCursor;

@ISA = qw{Properties};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new('Cursor',$_[0],'setCursor');

	bless($self,$class);
	return($self);
}

# exec the value and change the cursor
# takes numbers at the moment will change to standard names
sub exec_value {
	 my $self = shift;
	 my $object = shift;
	 my $thecmd = $self->{Command};
	 eval { $object->$thecmd(new QCursor($self->{Value}))};
}

# genrate the code for this simple command
sub generating {
	my $self = shift;
	my $varname = shift;
	print "\t\$" . $varname . "->";
	print $self->{Command} . "(new QCursor(" . $self->{Value} . "));\n";
}




#end propsetcursor
