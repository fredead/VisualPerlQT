
# $Id: controlpoints.pm,v 1.4 1998/05/18 16:40:20 simon Exp simon $
# simon
# Wed Apr  8 14:38:51 GMT 1998

# controlpoints
#  module to hold and manipulate (well sort off) a set
#  off control points  8 or 4 ???
# Try for 4 first then on to eaight

# It will have to generate the signals to tell
# the widget that it should change shape . there should
# also be a show hide thing for highlighting objects

package controlpoints;

use Qt;
use cpoint;
# Have a cursor for each point (just make it look nicer)
use QCursor qw(%Cursor);
use QObject;
# a slot for each point
use slots 'topleftmove(int,int)', 'toprightmove(int,int)', 'bottomleftmove(int,int)', 'bottomrightmove(int,int)';
use signals 'resizer(string)';

#inherit from QObject to allow connection
@ISA = qw{QObject};
# $parent GEMOTRY (x,y,h,w)

sub new {
	my $class = shift;
	my $self = $class->QObject::new($_[0]);

	# top left
	$self->{cps}[0] = new cpoint($_[0],$_[1],$_[2],$Cursor{sizeFDiag});
	# and connect
	$self->connect($self->{cps}[0],'newpos(int,int)','topleftmove(int,int)');

	# top right
	$self->{cps}[1] = new cpoint($_[0],$_[1]+$_[3],$_[2],$Cursor{sizeBDiag});
	$self->connect($self->{cps}[1],'newpos(int,int)','toprightmove(int,int)');

	# bottom left
	$self->{cps}[2] = new cpoint($_[0],$_[1],$_[2]+$_[4],$Cursor{sizeBDiag});
	$self->connect($self->{cps}[2],'newpos(int,int)','bottomleftmove(int,int)');

	#bottom right
	$self->{cps}[3] = new cpoint($_[0],$_[1]+$_[3],$_[2]+$_[4],$Cursor{sizeFDiag});
	$self->connect($self->{cps}[3],'newpos(int,int)','bottomrightmove(int,int)');

	# add to list
	$self->{geo}[0] = $_[1];
	$self->{geo}[1] = $_[2];
	$self->{geo}[2] = $_[3];
	$self->{geo}[3] = $_[4];


	bless ($self,$class);
	return $self;
}

# output for when saveing to temp file
sub saving {
	my $self = shift;
	print "(" . $self->{geo}[0] ."," . $self->{geo}[1];
	print "," . $self->{geo}[2] . "," . $self->{geo}[3] . ")\n";
}

# Set all the control points correct and tell
# the connected widget to resize itself
sub resetcps {
	my $self = shift;
	my $x = $self->{geo}[0];
	my $y = $self->{geo}[1];
	my $height = $self->{geo}[2];
	my $width = $self->{geo}[3];
	$self->{cps}[0]->move($x,$y);
	$self->{cps}[1]->move($x+$height,$y);
	$self->{cps}[2]->move($x,$y+$width);
	$self->{cps}[3]->move($x+$height,$y+$width);

	# Due to a limitation in the current implmentation of siganls and
	# slot only 3 arguments are allowed int or strings :( in version
	# 2 of PerlQt this may be changed :)
	emit $self->resizer($x . "," . $y . "," . $height . "," . $width);
}

# tell each contorlpoint to show itsself
sub show {
	my $self = shift;
	my $i = 0;
	for ( $i = 0 ; $i < 4 ; $i++ )
		{
		$self->{cps}[$i]->show();
		}
}

#tell each widget to hide its self
sub hide {
	my $self = shift;
	my $i = 0;
	for ( $i = 0 ; $i < 4 ; $i++ )
		{
		$self->{cps}[$i]->hide();
		}
}

# for when the widget move itself connect in the widget class
sub move {
	my $self = shift;
	my $newx = shift;
	my $newy = shift;
	$self->{geo}[0] = $newx;
	$self->{geo}[1] = $newy;
	$self->resetcps();
}

# Connection for each control point
# and set all the geometry correct and reset the widget
sub topleftmove {
	my $self = shift;
	my $difx = shift;
	my $dify = shift;
	# note Geo goes x,y,h,w 
	$self->{geo}[0] += $difx;
	$self->{geo}[1] += $dify;
	$self->{geo}[2] -= $difx;
	$self->{geo}[3] -= $dify;
	$self->resetcps();
}

sub toprightmove {
	my $self = shift;
	my $difx = shift;
	my $dify = shift;
	$self->{geo}[1] += $dify;
	$self->{geo}[2] += $difx;
	$self->{geo}[3] -= $dify;
	$self->resetcps();
}

sub bottomleftmove {
	my $self = shift;
	my $difx = shift;
	my $dify = shift;
	$self->{geo}[0] += $difx;
	$self->{geo}[2] -= $difx;
	$self->{geo}[3] += $dify;
	$self->resetcps();
}

sub bottomrightmove {
	my $self = shift;
	my $difx = shift;
	my $dify = shift;
	$self->{geo}[2] += $difx;
	$self->{geo}[3] += $dify;
	$self->resetcps();
}

# when im destroyed destroy each control point
sub DESTROY {
	my $self = shift;
	my $i = 0;
#	$self->hide();
	for ( $i = 0 ; $i < 4 ; $i++ )
		{
#		$self->{cps}[$i]->DESTROY();
		$self->{cps}[$i] = undef;
		}
	$self->SUPER::DESTROY();
}


