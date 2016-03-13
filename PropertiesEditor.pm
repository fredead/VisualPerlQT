
# $Id: PropertiesEditor.pm,v 1.3 1998/05/18 16:37:50 simon Exp simon $

# simon
# Wed Mar 25 00:28:51 GMT 1998
# 
# Class to edit properties and etc.
# Should be initated with a list (or hash)
# or properties class which will then be displayed
# and changed via this class 

package PropertiesEditor;

use Qt;
use QDialog;
use QPushButton;
use QLabel;
# Specail version of line edit which gives a number with it
# of which property it is
use mylineedit;

use slots 'valuechange(const string,int)','idie()';
use signals 'going()';

#Inherit from Qdialog ( this is mainly so connection can be setup)
# but also to have a window open to display output
@ISA = qw{QDialog};


sub new {
	my $class = shift;
	my $self = $class->SUPER::new();
	my $i = 0;
	my $j = 5;
	$self->setCaption("Properties Editor");

	# Now go through the properties lis
	while ( $_[0][$i] ne "NULL" )
		{
		# A nice label
		my $tlabel = new QLabel($self)->immortal;
		$tlabel->setText($_[0][$i]->get_text());
		$tlabel->setGeometry(5,$j,50,25);
		# an edit box (own design) to change the value
		my $editbox = new mylineedit($self,'LineEdit',$i)->immortal;
		$editbox->setText($_[0][$i]->get_value());
		$editbox->setGeometry(55,$j,230,25);
		$j = $j +30;
		$i++;
		# setup connection for chages
		$self->connect($editbox,'textChanged(const string,int)',
			'valuechange(const string,int)');
		}
	
	$self->{owncopy} = $_[0];

	# Setup a nice DONE push button
	my $pbutton = new QPushButton($self)->immortal;
	$pbutton->setText("Done");
	$pbutton->setGeometry(0,$j,300,25);
	$self->connect($pbutton,'released()','idie()');
	
	# Set a fixed sized depending on number o Properties
	# should expand to have scroll bars
	$self->setFixedSize(300,$j+25);
	$self->show();

	bless($self,$class);
	return $self;

}

# A value as been changed
# so change the properties value
sub valuechange {
	my $self = shift;
	my $value = shift;
	my $extra = shift;
	$self->{owncopy}[$extra]->set_value($value);
}

# What to do when the done button is pressed
sub idie {
	my $self = shift;
	emit $self->going();
	# Right call QDialog dunction done (which closes it all down)
	$self->done(1);
}
