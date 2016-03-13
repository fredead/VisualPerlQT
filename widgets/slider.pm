
# $Id: slider.pm,v 1.1 1998/05/18 16:47:32 simon Exp simon $
# simon Thu May 14 22:32:48 GMT 1998
# 
# package for slider widget 

package slider;

use widget;
#properties (few at the moment)
use propvarname;
use proptooltip;
use controlpoints;
use QSlider;
use QObject;
use Qt;
use signals 'dieing(int)';
use slots 'mousedown()', 'mouseup()', 'mousemove()','resetprops()','newgeo(string)', 'editor()', 'deleteme()';

# Inherit my class widget
@ISA = qw{widget QSlider};


sub new{
	# Get inhrited clas type (this can be done
 	# So that you can genrate objects from objects but I
	# don not wish that to happen at this moment in time
	my $super = shift;

	my $self = $super->QSlider::new($Orientation{Horizontal},$_[0]);

	$self->setGeometry($_[1],$_[2],$_[3],$_[4]);
	# reg with widget class
	$self->SUPER::init($_[0],$_[1],$_[2],$_[3],$_[4],"QSlider",$_[5]);

	#Setup Properties 	
	$self->addprop(new propsetcursor(2));
	$self->addprop(new proptooltip(''));

	bless ($self,$super);
	return $self;
}


sub destructor {
	my $self = shift;
	$self->QSlider::DESTROY();
}
