
# $Id$
# simon Thu May 14 22:32:48 GMT 1998
# 
# package for GENERIC widget 

# %s/GENERIC/ <WIDGET NAME>/g
# %s/QGENERIC/ <CLASS NAME>/g

package GENERIC;

use widget;
#properties (few at the moment)
use propvarname;
use proptooltip;
use controlpoints;
use QGENERIC;
use QObject;
use Qt;
use slots 'mousedown()', 'mouseup()', 'mousemove()','resetprops()','newgeo(string)', 'editor()', 'deleteme()';

# Inherit my class widget
@ISA = qw{widget QGENERIC};


sub new{
	# Get inhrited clas type (this can be done
 	# So that you can genrate objects from objects but I
	# don not wish that to happen at this moment in time
	my $super = shift;

	my $self = $super->QGENERIC::new($_[0]);

	$self->setGeometry($_[1],$_[2],$_[3],$_[4]);
	# reg with widget class
	$self->SUPER::init($_[0],$_[1],$_[2],$_[3],$_[4],"QGENERIC");

	#Setup Properties 	
	$self->addprop(new propsetcursor(2));
	$self->addprop(new proptooltip(''));

	bless ($self,$super);
	return $self;
}


sub destructor {
	my $self = shift;
	$self->QGENERIC::DESTROY();
}
