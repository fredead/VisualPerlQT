
#$Id: label.pm,v 1.5 1998/05/18 16:41:54 simon Exp simon $
# simon Tue Apr 28 20:02:47 GMT 1998
# 


package label;

use widget;
# all the properties it might have
use propsetext;
use propsetcursor;
use propsetalign;
use propvarname;
use proptooltip;
use controlpoints;
use QLabel;
use QObject;
use Qt;
use signals 'dieing(int)';
use slots 'mousedown()', 'mouseup()', 'mousemove()','resetprops()','newgeo(string)', 'editor()', 'deleteme()';

# Inherit my class widget
@ISA = qw{widget QLabel};


sub new{
	# Get inhrited class type (this can be done
 	# So that you can genrate objects from objects but I
	# don not wish that to happen at this moment in time
	my $super = shift;

	my $self = $super->QLabel::new($_[0]);
	
	# Set uo teh geomerry given
	$self->setGeometry($_[1],$_[2],$_[3],$_[4]);
	# set up inital stuff
	$self->setText("Label");
	$self->setAlignment($Align{Center});

	
	# goto wiget module for a setup	
	$self->SUPER::init($_[0],$_[1],$_[2],$_[3],$_[4],"QLabel",$_[5]);

	# add all my properties and set approtiately
	$self->addprop(new propsetext("Label"));
	$self->addprop(new propsetalign("Center"));
	$self->addprop(new propsetcursor(2));
	$self->addprop(new propvarname(''));
	$self->addprop(new proptooltip(''));

	bless ($self,$super);
	return $self;
}

# And a destructor to make sure it calls QLabel destroy
sub destructor {
	my $self = shift;
	$self->QLabel::DESTROY();
}
