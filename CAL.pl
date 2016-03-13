#!/usr/bin/perl
#Version 0.0003
# This program was auto generated by PerlQTRAD
#Copyright 1998 Simon Loader
#  If you need to edit this file (which you probably
# will) then the program is not fulling your needs

package gui;

# this is a use list
use Qt;
use QWidget;
use QPushButton;
use QLabel;
use QToolTip;
use QSlider;

#Slots to use / connections
use slots qw{};


@ISA = qw{QWidget};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new();

	$self->setMinimumSize(206,187);
	$self->setMaximumSize(206,187);
	my $RAD0 = new QPushButton($self)->immortal;
	$RAD0->setGeometry(25,45,30,30)
;
	$RAD0->setText("7");
	$RAD0->setCursor(new QCursor(2));
	QToolTip::add($RAD0,'but7');

	my $RAD1 = new QPushButton($self)->immortal;
	$RAD1->setGeometry(56,45,30,30)
;
	$RAD1->setText("8");
	$RAD1->setCursor(new QCursor(2));
	QToolTip::add($RAD1,'but8');

	my $RAD2 = new QPushButton($self)->immortal;
	$RAD2->setGeometry(56,76,30,30)
;
	$RAD2->setText("5");
	$RAD2->setCursor(new QCursor(2));
	QToolTip::add($RAD2,'but5');

	my $RAD3 = new QPushButton($self)->immortal;
	$RAD3->setGeometry(87,76,30,30)
;
	$RAD3->setText("6");
	$RAD3->setCursor(new QCursor(2));
	QToolTip::add($RAD3,'but6');

	my $RAD4 = new QPushButton($self)->immortal;
	$RAD4->setGeometry(25,76,30,30)
;
	$RAD4->setText("4");
	$RAD4->setCursor(new QCursor(2));
	QToolTip::add($RAD4,'but4');

	my $RAD5 = new QPushButton($self)->immortal;
	$RAD5->setGeometry(87,45,30,30)
;
	$RAD5->setText("9");
	$RAD5->setCursor(new QCursor(2));
	QToolTip::add($RAD5,'but9');

	my $RAD6 = new QPushButton($self)->immortal;
	$RAD6->setGeometry(87,107,30,30)
;
	$RAD6->setText("3");
	$RAD6->setCursor(new QCursor(2));
	QToolTip::add($RAD6,'but3');

	my $RAD7 = new QPushButton($self)->immortal;
	$RAD7->setGeometry(25,107,30,30)
;
	$RAD7->setText("1");
	$RAD7->setCursor(new QCursor(2));
	QToolTip::add($RAD7,'but1');

	my $RAD8 = new QPushButton($self)->immortal;
	$RAD8->setGeometry(56,107,30,30)
;
	$RAD8->setText("2");
	$RAD8->setCursor(new QCursor(2));
	QToolTip::add($RAD8,'but2');

	my $RAD9 = new QPushButton($self)->immortal;
	$RAD9->setGeometry(25,138,61,30)
;
	$RAD9->setText("0");
	$RAD9->setCursor(new QCursor(2));
	QToolTip::add($RAD9,'but0');

	my $RAD10 = new QPushButton($self)->immortal;
	$RAD10->setGeometry(87,138,30,30)
;
	$RAD10->setText(".");
	$RAD10->setCursor(new QCursor(2));
	QToolTip::add($RAD10,'butdot');

	my $RAD11 = new QPushButton($self)->immortal;
	$RAD11->setGeometry(119,107,28,61)
;
	$RAD11->setText("=");
	$RAD11->setCursor(new QCursor(2));
	QToolTip::add($RAD11,'buteq');

	my $RAD12 = new QPushButton($self)->immortal;
	$RAD12->setGeometry(118,76,30,30)
;
	$RAD12->setText("+");
	$RAD12->setCursor(new QCursor(2));
	QToolTip::add($RAD12,'butplus');

	my $RAD13 = new QPushButton($self)->immortal;
	$RAD13->setGeometry(118,45,30,30)
;
	$RAD13->setText("-");
	$RAD13->setCursor(new QCursor(2));
	QToolTip::add($RAD13,'butminus');

	my $RAD14 = new QLabel($self)->immortal;
	$RAD14->setGeometry(25,7,152,31)
;
	$RAD14->setText("0");
	$RAD14->setAlignment($Align{Right});
	$RAD14->setCursor(new QCursor(2));
	$self->{messagebox} = $RAD14;

	my $RAD15 = new QPushButton($self)->immortal;
	$RAD15->setGeometry(149,45,30,30)
;
	$RAD15->setText("*");
	$RAD15->setCursor(new QCursor(2));

	my $RAD16 = new QPushButton($self)->immortal;
	$RAD16->setGeometry(149,76,30,30)
;
	$RAD16->setText("/");
	$RAD16->setCursor(new QCursor(2));

	my $RAD17 = new QPushButton($self)->immortal;
	$RAD17->setGeometry(149,107,30,30)
;
	$RAD17->setText("C/CE");
	$RAD17->setCursor(new QCursor(2));

	my $RAD18 = new QPushButton($self)->immortal;
	$RAD18->setGeometry(149,138,30,30)
;
	$RAD18->setText("AC");
	$RAD18->setCursor(new QCursor(2));



	if ($self->can('init'))
		{
		$self->init();
		}
	bless ($self,$class);
	return $self;
}





sub init {
	my $self = shift;
	$self->{'screen'} = 0;
	$self->{'func'} = 'plus';
	$self->{'memory'} = 0;
}

sub updatescreen {
    my $self = shift;
    my $insert = shift;
    if ( $self->{'screen'} == 0 and $insert ne '' ) {
         $self->{'screen'} = $insert;
    } else {
        $self->{'screen'} = $self->{'screen'} . $insert;
    }
    $self->{messagebox}->setText($self->{'screen'});
}


sub but1 {
    my $self = shift;
    $self->updatescreen('1');
}
sub but2 {
    my $self = shift;
    $self->updatescreen('2');
}
sub but3 {
    my $self = shift;
    $self->updatescreen('3');
}
sub but4 {
    my $self = shift;
    $self->updatescreen('4');
}
sub but5 {
    my $self = shift;
    $self->updatescreen('5');
}
sub but6 {
    my $self = shift;
    $self->updatescreen('6');
}
sub but7 {
    my $self = shift;
    $self->updatescreen('7');
}
sub but8 {
    my $self = shift;
    $self->updatescreen('8');
}
sub but9 {
    my $self = shift;
    $self->updatescreen('9');
}
sub but0 {
    my $self = shift;
    $self->updatescreen('0');
}
sub butdot {
    my $self = shift;
    $self->updatescreen('.');
}
sub buteq {
    my $self = shift;
    if ( $self->{'func'} eq 'plus' )
        {
        $self->{'screen'} = $self->{'memory'} + $self->{'screen'};
        $self->{'memory'} = 0;
        $self->updatescreen('');
        }
    if ( $self->{'func'} eq 'minus' )
        {
        $self->{'screen'} = $self->{'memory'} - $self->{'screen'};
        $self->{'memory'} = 0;
        $self->updatescreen('');
        }
}
sub butplus {
    my $self = shift;
    $self->{'func'} = 'plus';
    $self->{'memory'} = $self->{'screen'};
    $self->{'screen'} = 0;
    $self->updatescreen('');
}
sub butminus {
    my $self = shift;
    $self->{'func'} = 'minus';
    $self->{'memory'} = $self->{'screen'};
    $self->{'screen'} = 0;
    $self->updatescreen('');
}





package main;
use Qt;

$mygui = new gui;
$qApp->setMainWidget($mygui);
$mygui->show();
exit $qApp->exec();
