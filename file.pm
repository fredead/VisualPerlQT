
#$Id: file.pm,v 1.3 1998/05/18 16:41:14 simon Exp simon $
# simon Tue Apr 28 21:59:15 GMT 1998
#
# file.pl
#   Module to take care of file processors to do with the main code
# opening , closing and generation


package file;

use QObject;
# connection to it
use slots 'load()', 'save()', 'saveas()', 'genfile()', 'wipeinfo()';
# signals to send to other classes
use signals 'saveing()', 'loading()', 'clear()', 'generate()';

@ISA = qw{QObject};


sub new {
	my $class = shift;
	my $self = $class->QObject::new();

	# set up some names
	$self->{name} = "";
	$self->{gen_name} = "";

	bless ($self,$class);
	return $self;
}

# fro when a new call happens (hey we dont want to save ocer other
# data)
sub wipeinfo {
	my $self = shift();
	$self->{name} = "";
	$self->{gen_name} = "";
	emit $self->clear();
}

# load a file
sub load {
	my $self = shift;
	my $gen = "";
	my $filename = "";

	# get a name (bug somewhere)
	$filename = QFileDialog::getOpenFileName('.');

	if ( defined($filename)  ) 
		{
		$self->{name} = $filename;
		# setup gen name for file
		$gen = $filename;
		$gen =~ s/RAD$//;
		$self->{gen_name} = $gen . "pl";
		# clear current canvas
		emit $self->clear();

		# open to stdin
		open STDIN , "<$filename" or die "Cant open $filename: $!\n";
		my $comment = <STDIN>;
		# ignore comments (shoudl check version HERE
		while ( $comment =~ /^#/ )
			{
			$comment = <STDIN>;
			}
		# loadit
		emit $self->loading();
		close STDIN;
		open STDIN , "STDIN";
		}
}

# save a temporary file 
sub save {
	my $self = shift;
	if ( $self->{name} ne ""  )
		{
		open FILEHD , ">$self->{name}" or die "Cant open $self->{file}: $!\n";
		my $oldfd = select FILEHD;

		# version number should be done better to allow checking
		print "#Prad v0.0003 Y aint that autoted\n";
		print "# Simon Loader Copyright 1998\n";
		# let the other modules produce there output
		emit $self->saveing();
		close FILEHD;
		select $oldfd;
		}

}

# get the name and then save
sub saveas {
	my $self = shift;
	my $filename = QFileDialog::getSaveFileName(".");
	if ( defined($filename) )
		{
		$filename =~ s/.RAD$//;
		$filename = $filename . ".RAD";
		$self->{name} = $filename;
		$self->save();
		}
}

# routine to open main program and call other
# parts to generate the code
sub genfile {
	my $self = shift;
	# If we have a name we go ahead
	if ( $self->{gen_name} ne "" )
		{
		open FILEHD , ">$self->{gen_name}" or die "Cant open $self->{gen_name}: $!\n";
		# set to stdout so print can be used
		my $oldfd = select FILEHD;

		# get generating
		emit $self->generate();
		
		#set it all back to normal
		close FILEHD;
		select $oldfd;
		chmod 0755,$self->{gen_name};
	}
}
