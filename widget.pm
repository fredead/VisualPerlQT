
# $Id: widget.pm,v 1.15 1998/12/13 01:25:32 simon Exp simon $
# simon Sat Mar 21 17:38:40 GMT 1998
# Widget class to be inherited by all 
# Placeable widgets 

# Data
# Contorl Points
# properties
# geometry

# methods
# Display
# Isinyou ?? (Could set up a connection ??)
# Is in control point (could set up a connection ??)
# 


package widget;

use Qt;
use QObject;
use QPopupMenu;
use Properties;
use PropertiesEditor;
use controlpoints;
use signals 'dieing(int)';
use slots 'resetprops()','newgeo(string)', 'editor()', 'deleteme()';

# replacement for new as widgets multi inherot
sub init {
	my $self = shift;
	# set up the mouse
	$self->setMouseTracking(1);
	$self->{mouse} = "UP";
	# set up properties list
	$self->{props}[0] = "NULL";
	# now the control points and
	# set up connection for them
	$self->{cps} = new controlpoints($_[0],$_[1],$_[2],$_[3],$_[4]);
	$self->connect($self->{cps},'resizer(string)','newgeo(string)');
	$self->{cps}->show();
	
	# special for the code producing
	$self->{code} = $_[5];

	# setup a menu on the right mouse button
	my $popup = new QPopupMenu->immortal;
	$popup->insertItem('Properties',$self,'editor()');
	$popup->insertItem('Delete',$self,'deleteme()');
	$self->{menu} = $popup; 

	# what number in the canvas array am I ??
	$self->{number} = $_[6];



}


sub mousePressEvent {
	my $self = shift;
	my $mouse = shift;
	my $state = $mouse->button();
	$self->{xmstartpos} = $mouse->x();
	$self->{ymstartpos} = $mouse->y();
	#Left button
	if ( $state == 1 )
		{
		$self->{mouse} = "down";
		}
	# Right button
	if ( $state == 2 )
		{
		#Display a popup menu
		my $parent = $self->parent();
		$self->{menu}->move(QCursor::pos());
		$self->{menu}->show();
		}
}


sub mouseMoveEvent {
	my $self = shift;
	my $mouse = shift;
	my $posx = $mouse->x();
	my $posy = $mouse->y();
	if ( $self->{mouse} eq "down" )
		{
		# Ok left button down so its time to move abour
		# If you just tell the control points they will tell
		# me again
		$self->{cps}->move($posx-$self->{xmstartpos}+$self->x()
			,$posy-$self->{ymstartpos}+$self->y());
		}
}



sub mouseReleaseEvent {
# If right mouse button is relesed no signal is sent
#  STRANGE ??? BUG ???
	my $self = shift;
	my $mouse = shift;
	my $state = $mouse->button();
	# left up then not moving
	if ( $state == 1 )
		{
		$self->{mouse} = "UP";
		}
}

# spawn of a the properties editor connected to
# popup menu
sub editor {
	my $self = shift;
	my $edit = new PropertiesEditor($self->{props})->immortal;
	$self->connect($edit,'going()','resetprops()');
}

# kill myself sonnected to popup menu
# should really call Canavas to delete of system ???
# but if I call canvas what happens the the staack
# THIS NEEDS WORK ++++++
sub deleteme {
	my $self = shift;
	emit $self->dieing($self->{number});
	#$self->DESTROY();
}

# OK some properties have change so update them all
# called from properties editor
sub resetprops {
    my $self = shift;
    my $i = 0;
	# go through each one in turn
    while ( $self->{props}[$i] ne "NULL" )
        {
        $self->{props}[$i]->exec_value($self);
        $i++;
        }
}

# add a property to the list
sub addprop {
	my $self = shift;
	my $newprop = shift;
	my $i = 0;

	# find the end
	while ( $self->{props}[$i] ne "NULL" )
		{
		$i++;
		}
	#add the property
	$self->{props}[$i] = $newprop;
	$self->{props}[$i+1] = "NULL";
}

# I have a new geomerty (this is for control points)
# not $list is a string as Can only pass 3 elements with
# slots and signals 
sub newgeo {
    my $self = shift;
	my $list = shift;
	my ( $x , $y , $h , $w ) = split /,/ , $list , 4;
	$self->setGeometry($x,$y,$h,$w);
}

# save file to temp file
sub saveing {
	my $self = shift;
	my $i = 0;
	# tell it what I am 
	print ref($self);
	# give me dimentions (auto)
	$self->{cps}->saving();
	# and a litlle start
	print "BEGIN\n";
	# now do properties
	while ( $self->{props}[$i] ne "NULL" )
		{
		# print out what the property is (skipped as not required)
		#print ref($self->{props}[$i]);
		# Tell the property to save itself
		$self->{props}[$i]->saving();
		$i++;
		}
	# and a end mark
	print "END\n"; 
		
}

# load from stdin and setit all ip
sub loading {
	my $self = shift;
	my $i = 0;
	my $mestdin = <STDIN>;
	# Canavas leaves us on the line before
	$mestdin = <STDIN>;
	# wait till we get to the end
	while ( $mestdin ne "END\n" )
		{
		$mestdin =~ s/\n//;   # arent I suppose to use chop (nope)
		$mestdin =~ s/^ //;
		# set the value, not ths is prsumed to be in the
		# same order shoudl do something more clever
		$self->{props}[$i]->set_value($mestdin);
		$i++;
		$mestdin = <STDIN>;
		}

	# kick it all in
	$self->resetprops();
}

# get those slts from possible properties which are 
# really connections
sub genslots {
	my $self = shift;
	my $i = 0;

	while ( $self->{props}[$i] ne "NULL" )
		{
		# if it has a function get_slot and a value then
		# thats the one we want
		if ( $self->{props}[$i]->get_value ne "" && $self->{props}[$i]->can('get_slot') )
			{
			$self->{props}[$i]->get_slot;
			print " ";
			}
		$i++;
		}
}

# genrate code for the widget
# name is the internal name in code
sub gencode {
	my $self = shift;
	my $name = shift;
	my $i = 0;

	print "\tmy \$" . $name . " = new ";
	print $self->{code} . "(\$self)->immortal;\n";
	print "\t\$" . $name . "->setGeometry";
	$self->{cps}->saving();
	print ";\n";


	# now properties
	while ( $self->{props}[$i] ne "NULL" )
		{
		if ( $self->{props}[$i]->get_value ne "" )
			{
				$self->{props}[$i]->generating($name);
			}
		$i++;
		}

	print "\n";
	
}


sub DESTROY {
	my $self = shift;
	my $i = 0;
 
	# For compatibilty incase a property needs seem destruction
	while ( $self->{props}[$i] ne "NULL" )
		{
#		$self->{props}[$i]->DESTROY();
		$self->{props}[$i] = undef;
		$i++;
		}
#	$self->{cps}->DESTROY();
	$self->{cps} = undef;
	$self->destructor();
}




#end widgets
1;
