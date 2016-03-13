
# $Id: qlinedit.pm,v 1.1 1998/05/18 16:47:17 simon Exp simon $
# simon Thu May 14 22:32:48 GMT 1998
# 

# package for a line edit widget

package qlinedit;

use widget;
# properties
use propvarname;
use proptooltip;
use propvarname;
use propsetext;
use propsetcursor;
use controlpoints;
use QLineEdit;
use QObject;
use Qt;
use signals 'dieing(int)';
use slots 'mousedown()', 'mouseup()', 'mousemove()','resetprops()','newgeo(string)', 'editor()', 'deleteme()';

# Inherit my class widget
@ISA = qw{widget QLineEdit};


sub new{
	# Get inhrited clas type (this can be done
 	# So that you can genrate objects from objects but I
	# don not wish that to happen at this moment in time
	my $super = shift;

	my $self = $super->QLineEdit::new($_[0]);
	
	# set up geo
	$self->setGeometry($_[1],$_[2],$_[3],$_[4]);
	
	# initate with widget class	
	$self->SUPER::init($_[0],$_[1],$_[2],$_[3],$_[4],"QLineEdit",$_[5]);

	# Add all the properties
	$self->addprop(new propsetcursor(2));
	$self->addprop(new proptooltip(''));
	$self->addprop(new propsetext(''));
	$self->addprop(new propvarname(''));

	bless ($self,$super);
	return $self;
}


sub destructor {
	my $self = shift;
	$self->QLineEdit::DESTROY();
}
