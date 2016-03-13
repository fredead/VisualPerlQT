
# $Id: mylineedit.pm,v 1.3 1998/05/18 16:43:00 simon Exp simon $
# simon
# Thu Mar 26 21:34:40 GMT 1998
#
# A package to be able to override the
# textChanged function of QLineEdit (very simple really
# this is beacuse I require more infomration about the
# wihc one has changed 

package mylineedit;

use Qt;
use QLineEdit;
use signals 'textChanged(const string,int)';
use slots 'myslot(const string)';

@ISA = qw{QLineEdit};

sub new {
	my $class = shift;
	my $self = $class->QLineEdit::new($_[0],$_[1]);

	# remeber my number
	$self->{num} = $_[2];
	$self->connect($self,'textChanged(const string)','myslot(const string)');

	bless($self,$class);

	return $self;
}

# return my number and the text
sub myslot {
	my $self = shift;
	my $string = shift;
	my $num = $self->{num};
	emit $self->textChanged($string,$num);
}

