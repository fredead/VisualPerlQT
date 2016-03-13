# Canvas class
# $Id: Canvas.pm,v 1.10 1998/05/18 16:36:13 simon Exp simon $
# simon loader Fri Mar 20 02:24:59 GMT 1998

# This class is for the creation of a canvas on the plane
# it is the direct interface for the user (/programmer)
# It will display and control widgets that are designed within the system

# Public functions 
#  Display -- Display teh canvas
#      This is really taken care in QWidget which this class
#      Inherits off
#  AddWidget(Widget) -- add a widget to the list of widgets
#  Delwidget(widget) -- Delete a widget from the list of widgets
#  Resize()  -- resize the canvas size (dont know quite how to do 
#	this ???


package Canvas;


# We are going to play with some nice cursors 
use QCursor qw(%Cursor);  

use Qt;
use QEvent;
# Property stuff

# list of possible widgets
use pushbutton;
use label;
use slider;
use qlinedit;

# Signals that can be sent to it
use slots qw{mousePressEvent() writout() loadin() generate() clearout() set_widgettype(string) getslots() delwidget(int)};

# should this be an object or dialog or a widget ???
# Widget chossen at it fullfiles all possible requirements at this
# moment in time
@ISA = qw(QWidget);

sub new {
	my $class = shift;
	my $self = $class->SUPER::new(@_);

	# Empty array for all the widgets in the canvas
	$self->{widgets} = [];   
	$self->{"pos"} = 0;
	
	# intial size
	$self->setGeometry(20,20,200,200);

	#  Ill have a cross type cursor
	my $mycursor = new QCursor($Cursor{cross});
	$self->setCursor($mycursor);

	# set up default widget to use
	$self->{widgettype} = "pushbutton";
	
	bless ($self,$class);
	return $self;
}

# Event automatically called when a mouse button
# is pressed within the canvas window.
sub mousePressEvent {
	my $self = shift;
	my $mouse = shift;
	# Get mouse cursor position
	my $xpos = $mouse->x();
	my $ypos = $mouse->y();
	
	# Create a new widget and insert in list
	# POSITION MIGHT BE WRONG HERE SHOULD BE OK ??
	my $thecmd = 'new ' . $self->{widgettype} . '($self,$xpos,$ypos,30,30,$self->{"pos"})';
	my $widget = eval $thecmd ;

	# Check for error should never be called :)
	if ( $@) 
		{
			#should emit to a nice object
			print "Error $@\n";
		}
	else
		{
		$widget->show();
		$self->addwidget($widget);
		}


}


# Add a widget to the widget array
sub addwidget {
	my $self = shift;
	my $newidget = shift;

	$self->{widgets}[$self->{"pos"}] = $newidget;
	$self->{"pos"}++;

	$self->connect($newidget,'dieing(int)','delwidget(int)');

}

sub delwidget {
	my $self = shift;
	my $thepos = shift;

	# shift them all down one
	#$self->{widget}[$thepos]->DESTROY;
	while ( $thepos != $self->{"pos"} )
		{
		$self->{widgets}[$thepos] = $self->{widgets}[$thepos + 1];
		$thepos++;
		}
	# now kill the last entry and minus one of the total
	# this should be ok for when goes off bottom CHECK
	$self->{widgets}[$self->{"pos"}] = undef;
	$self->{"pos"}--;

}

# Wipe all widgets from Canvas
sub clearout {
	my $self = shift;
	my $i = 0;
	for ( $i = 0 ; $i < $self->{"pos"} ; $i++ )
		{
		$self->{widgets}[$i]->DESTROY();
		}
	$self->{"pos"} = 0;
}

# Save out to temporary file
sub writout {
	my $self = shift;
	my $i = 0;

	# ok its a bit dodgy genrating real code but 
	# it doesnt seem to matter that much :~
	# plus its really useful for loading back in
	print "CANVAS START\n";
	print "setGeometry(" . $self->x() . "," . $self->y() . ",";
	print $self->width() . "," . $self->height() . ")\n";
	# In the future they may be othe thing to preserve 
	# e.g. colour , cursor etc but this is for later and when
	# the canvas uses properties for itself
	print "CANVAS END\n";

	# now recurse (Im not using recusion here) down
	# list of objects.
	for ( $i = 0 ; $i < $self->{"pos"} ; $i++ )
		{
		$self->{widgets}[$i]->saveing();
		}

}

#Load in from the temporary file
sub loadin {
	my $self = shift;
	my $i = 0;
	my $mystdin = <STDIN>;

	# Find start
	while ( $mystdin !~ /^CANVAS START$/ )
		{
		$mystdin = <STDIN>;
		}
	$mystdin = <STDIN>;
	# Now go until the end setting up the canavas
	while ( $mystdin !~ /^CANVAS END$/ )
		{
		my $cmd = "\$self->" . $mystdin;
		eval $cmd;
		$mystdin = <STDIN>;
		}
		$mystdin = <STDIN>;
	# now for all the widgets until end of file
	while ( defined($mystdin) )
		{
		# Creatate it
		$cmd = "\$self->{widgets}[$i] = new " . $mystdin; 
		$cmd =~ s/\(/\(\$self,/;
		eval $cmd;

		# Set the properties and show
		$self->{widgets}[$i]->loading();
		$self->{widgets}[$i]->show();

		# NEXT
		$mystdin = <STDIN>;
		$i++;
		}
	$self->{"pos"} = $i;
}

# Get the slots (action that are active) upon each 
# widget 
sub getslots {
	my $self = shift;
	my $i = 0;

	for ( $i = 0 ; $i < $self->{"pos"} ; $i++ )
		{
		$self->{widgets}[$i]->genslots();
		}

}

# Generate that code for the program
sub generate {
	my $self = shift;
	my $i = 0;

	# Used for temp variable name
	my $names = "RAD";
	print "\n";
	print "\@ISA = qw{QWidget};\n";
	print "\n";
	print "sub new {\n";
	print "\tmy \$class = shift;\n";
	print "\tmy \$self = \$class->SUPER::new();\n\n";
	print "\t\$self->setMinimumSize(";
	print $self->width() . "," . $self->height() . ");\n";
	print "\t\$self->setMaximumSize(";
	print $self->width() . "," . $self->height() . ");\n";

# This will move the display to the desired area 
# commented out becuase not that nice
#	print "\t\$self->move(";
#	print $self->y() . "," . $self->x() . ");\n";

	# insert my properties
	# No properties prsent at moment
	# insert all widgets
	for ( $i = 0 ; $i < $self->{"pos"} ; $i++ )
		{
		$self->{widgets}[$i]->gencode($names . $i);
		}

	# Check if init exists and run it if it does
	print "\n\n\tif (\$self->can('init'))\n";
	print "\t\t{\n";
	print "\t\t\$self->init();\n";
	print "\t\t}\n";

	# Tidy up
	print "\tbless (\$self,\$class);\n";
	print "\treturn \$self;\n";
	print "}\n\n";
}

# Set the type of widgets that will be
# created with the next mouse press.
sub set_widgettype {
	my $self = shift;
	my $widgettype = shift;
	$self->{widgettype} = $widgettype;
}

# Overide close so that the canvas can only be closed from
# the menu system

sub close {
}
	

# end Canvas
