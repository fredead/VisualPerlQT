
# $Id: cpoint.pm,v 1.6 1998/12/13 01:26:45 simon Exp simon $
# simon Tue Apr  7 20:37:05 GMT 1998
# cpoint.pm
#
#   Contorl point module to genrate and hold postion blah blha
# of a control point 

# Data
# x pos y pos

# functions
# slot for when a point is clicked on
# and for movement (see widget.pm) for advace
# 
#  It would be nice to change the cursor depending on position 
# realtive to thw widegt been moved . 

#   cpointS setups several cpoint controlling a signal
#  taht is emitted when movement occurs in thsi class 
#  it that sorts out the values for the next bit.
#   Also passes what cursor and position is required ?

package cpoint;

use Qt;
use QColor;
use QWidget;
use signals 'newpos(int,int)';
use QCursor qw(%Cursor);

@ISA = qw{QWidget};

sub new {
	my $super = shift;
	my $self = $super->QWidget::new($_[0]);
	
	#set up a 5 by 5 block
	$self->setGeometry($_[1]-2,$_[2]-2,4,4);

	# Set a nice colour
	#$self->setBackgroundColor(QColor::new('DarkSlateGray'));
	$self->setBackgroundColor(QColor::new('Black'));
	
	# Set up a cursor 
	$self->setCursor($_[3]);


	# Setup the tracking
	$self->setMouseTracking(1);
	$self->{mouse} = "UP";
	
	bless ($self,$super);
	return $self;
}


# Nicked from widget (couldnt this inherit ???)
# ste moyse variable to down when button is pressed in this point
sub mousePressEvent {
	my $self = shift;
	my $mouse = shift;
	my $state = $mouse->button();
	$self->{xmstartpos} = $mouse->x();
	$self->{ymstartpos} = $mouse->y();
	if ( $state == 1 )
		{
		$self->{mouse} = "down";
		}
}

# If where moveing and the left mouse button is donw then
# move the widget
sub mouseMoveEvent {
	my $self = shift;
	my $mouse = shift;
	my $posx = $mouse->x();
	my $posy = $mouse->y();
	if ( $self->{mouse} eq "down" )
		{
		emit $self->newpos($posx-$self->{xmstartpos},$posy-$self->{ymstartpos});
		}
}

#Just set mouse variable to up so movement does
# not effect widget anymore
sub mouseReleaseEvent {
    my $self = shift;
    my $mouse = shift;
    my $state = $mouse->button();
    if ( $state == 1 )
        {
        $self->{mouse} = "UP";
        }
}

# move to new position (note -2 to get correct position ,
# query will this work for bottom right ?? Looks alright
sub move {
	my $self = shift;
	my $x = shift;
	my $y = shift;
	$self->SUPER::move($x-2,$y-2);
}

# destroy myself (this is not really required 
#sub DESTROY {
#	my $self = shift;
#	$self->QWidget::DESTROY();
#}
