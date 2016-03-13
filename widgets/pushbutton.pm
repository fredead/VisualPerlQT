
#$Id: pushbutton.pm,v 1.12 1998/05/18 16:46:42 simon Exp simon $
# simon Sun Mar 22 19:57:15 GMT 1998
# 


package pushbutton;

use widget;
# my properties list and connections
use propsetext;
use propsetcursor;
use propvarname;
use proptooltip;
use connpressed;
use connreleased;
use connclicked;
use controlpoints;
use QPushButton;
use QObject;
use Qt;
use signals 'dieing(int)';
use slots 'resetprops()','newgeo(string)', 'editor()', 'deleteme()';

# Inherit my class widget
@ISA = qw{widget QPushButton};


sub new{
	# Get inhrited clas type (this can be done
 	# So that you can genrate objects from objects but I
	# don not wish that to happen at this moment in time
	my $super = shift;

	my $self = $super->QPushButton::new($_[0]);
	
	# Setup geometry and some default values
	$self->setGeometry($_[1],$_[2],$_[3],$_[4]);
	$self->setText("Button");

	
	# iniate with widget base class	
	$self->SUPER::init($_[0],$_[1],$_[2],$_[3],$_[4],"QPushButton",$_[5]);

	# add all me properties
	$self->addprop(new propsetext("Button"));
	$self->addprop(new propsetcursor(2));
	$self->addprop(new connpressed(""));
	$self->addprop(new proptooltip(''));
	$self->addprop(new connreleased(""));
	$self->addprop(new connclicked(""));

	bless ($self,$super);
	return $self;
}


sub destructor {
	my $self = shift;
	$self->QPushButton::DESTROY();
}
