
# $Id: menu.pm,v 1.5 1998/05/01 12:19:08 simon Exp simon $
# simon 
# a menu system for my application :)
#
package menu;

use QColor;
use QMenuBar;
use QFileDialog;
use QMessageBox;
use QGlobal qw(%Key $CTRL);
use Qt;

# all the different signals that can be sent for each option
use signals 'saveing()', 'saveingas()', 'loading()' , 'generate()', 'setwidget(string)', 'clear()', 'forkedit()';


# Setup slots to connect to menu
# Items and such like 
# ??? There must be a way to parse 
#    this and use it to make the menus ???
use slots qw{
	newfile()
	open()
	save()
	myclose()
	saveas()
	about()
	copy()
	paste()
	cut()
	properties()
	pushbutton()
	textarea()
	slider()
	linedit()
	spawnedit()
	build()
	help()
	test()
};

#Inherit QWidget 
@ISA = qw(QWidget);  

sub new {
	my $self = shift->SUPER::new(@_);
	
	#Setup file menu
	my $file = new QPopupMenu->immortal;
	$file->insertItem('New', $self, 'newfile()');
	$file->insertItem('Open', $self, 'open()', $CTRL+$Key{O});
	$file->insertItem('Save', $self, 'save()', $CTRL+$Key{S});
	$file->insertItem('Close', $self, 'myclose()', $CTRL+$Key{C});
	$file->insertItem('SaveAs', $self, 'saveas()',  $CTRL+$Key{A});
	$file->insertSeparator();
	$file->insertItem('About', $self, 'about()');
	$file->insertItem('Exit', $qApp, 'quit()', $CTRL+$Key{Q});

	#Setup edit menu

	my $edit = new QPopupMenu->immortal;
	$edit->insertItem('Cut', $self, 'cut()', $CTRL+$Key{X});
	$edit->insertItem('Copy', $self, 'copy()', $CTRL+$Key{C});
	$edit->insertItem('Paste', $self, 'paste()', $CTRL+$Key{V});
	$edit->insertSeparator();
	$edit->insertItem('Properties', $self, 'properties()');
	
	#Setup widget menu (Push buttons will be used as well??)
	my $widgetlist = new QPopupMenu->immortal;
	$widgetlist->insertItem('PushButton', $self, 'pushbutton()');
	$widgetlist->insertItem('Label', $self, 'textarea()');
	$widgetlist->insertItem('Slider', $self, 'slider()');
	$widgetlist->insertItem('Line Edit', $self, 'linedit()');

	# Setup build menu
	my $build = new QPopupMenu->immortal;
	$build->insertItem('EditCode', $self, 'spawnedit()');
	$build->insertItem('build', $self, 'build()');
	$build->insertItem('test', $self, 'test()');


	# Setup Help Menu
	my $help = new QPopupMenu->immortal;
	$help->insertItem('HELP!!', $self, 'help()');

	# Insert them all into the menu
	my $menu = new QMenuBar($self);
	$menu->insertItem('&File',$file);
	$menu->insertItem('&Edit', $edit);
	$menu->insertItem('&Widgets',$widgetlist);
	$menu->insertItem('&Build',$build);
	$menu->insertSeparator();
	$menu->insertItem('&Help', $help);

	# Fix my size
	$self->setMinimumSize(320, 80);
	$self->setMaximumSize(320, 80);
	

	#set a background colour
	$self->setBackgroundColor(QColor::new('Black'));

	@$self{'menu'} = ($menu);
     
	
	return $self;

}

#  Delete everything in the canvas
sub newfile() {
	my $self = shift;
	emit $self->clear();
}


# Delete the cnavas and open a newfile for paseing 
sub open() {
	my $self = shift;
	emit $self->loading();
}

# save to knowen filename 
# if no knowen filename then save as
sub save() {
	my $self = shift;
	emit $self->saveing();
}

# Much the same as new at this moment in time
sub myclose() {
	my $self = shift;
	emit $self->clear();
}

# Get a filename for saving too
sub saveas() {
	my $self = shift;
	emit $self->saveingas();
}

# A little about message :0
sub about() {
	QMessageBox::message("About","PerlQT Designer\nby Simon Loader\n
		A project for Yan","Done");
}

# edit stuff notr connected at the moment 
# DO groups arg
sub copy() {}
sub paste() {}
sub cut() {}
sub properties() {}

# Set up pushbuttons
sub pushbutton() {
	my $self = shift;
	emit $self->setwidget("pushbutton");
}
sub textarea() {
	my $self = shift;
	emit $self->setwidget("label");
}
sub slider() {
	my $self = shift;
	emit $self->setwidget("slider");
}
sub linedit() {
	my $self = shift;
	emit $self->setwidget("qlinedit");
}

# go build the code into a file
sub build() {
	my $self = shift;
	emit $self->generate();
}

# start up teh editor
sub spawnedit {
	my $self = shift;
	emit $self->forkedit();
}

# display some help
sub help() {}

# run the genrated program
sub test() {}


# end menu

