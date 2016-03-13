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
use slots qw{but7() but8() but5() but6() but4() but9() but3() but1() but2() but0() butdot() buteq() butplus() butminus() multi() divide() cleardisplayandmem() };


@ISA = qw{QWidget};

sub new {
	my $class = shift;
	my $self = $class->SUPER::new();

	$self->setMinimumSize(341,182);
	$self->setMaximumSize(341,182);
	my $RAD0 = new QPushButton($self)->immortal;
	$RAD0->setGeometry(25,45,30,30)
;
	$RAD0->setText("7");
	$RAD0->setCursor(new QCursor(2));
	$self->connect($RAD0,'pressed()','but7()');
	QToolTip::add($RAD0,'7');

	my $RAD1 = new QPushButton($self)->immortal;
	$RAD1->setGeometry(56,45,30,30)
;
	$RAD1->setText("8");
	$RAD1->setCursor(new QCursor(2));
	$self->connect($RAD1,'pressed()','but8()');
	QToolTip::add($RAD1,'8');

	my $RAD2 = new QPushButton($self)->immortal;
	$RAD2->setGeometry(56,76,30,30)
;
	$RAD2->setText("5");
	$RAD2->setCursor(new QCursor(2));
	$self->connect($RAD2,'pressed()','but5()');
	QToolTip::add($RAD2,'5');

	my $RAD3 = new QPushButton($self)->immortal;
	$RAD3->setGeometry(87,76,30,30)
;
	$RAD3->setText("6");
	$RAD3->setCursor(new QCursor(2));
	$self->connect($RAD3,'pressed()','but6()');
	QToolTip::add($RAD3,'6');

	my $RAD4 = new QPushButton($self)->immortal;
	$RAD4->setGeometry(25,76,30,30)
;
	$RAD4->setText("4");
	$RAD4->setCursor(new QCursor(2));
	$self->connect($RAD4,'pressed()','but4()');
	QToolTip::add($RAD4,'4');

	my $RAD5 = new QPushButton($self)->immortal;
	$RAD5->setGeometry(87,45,30,30)
;
	$RAD5->setText("9");
	$RAD5->setCursor(new QCursor(2));
	$self->connect($RAD5,'pressed()','but9()');
	QToolTip::add($RAD5,'9');

	my $RAD6 = new QPushButton($self)->immortal;
	$RAD6->setGeometry(87,107,30,30)
;
	$RAD6->setText("3");
	$RAD6->setCursor(new QCursor(2));
	$self->connect($RAD6,'pressed()','but3()');
	QToolTip::add($RAD6,'3');

	my $RAD7 = new QPushButton($self)->immortal;
	$RAD7->setGeometry(25,107,30,30)
;
	$RAD7->setText("1");
	$RAD7->setCursor(new QCursor(2));
	$self->connect($RAD7,'pressed()','but1()');
	QToolTip::add($RAD7,'1');

	my $RAD8 = new QPushButton($self)->immortal;
	$RAD8->setGeometry(56,107,30,30)
;
	$RAD8->setText("2");
	$RAD8->setCursor(new QCursor(2));
	$self->connect($RAD8,'pressed()','but2()');
	QToolTip::add($RAD8,'2');

	my $RAD9 = new QPushButton($self)->immortal;
	$RAD9->setGeometry(25,138,61,30)
;
	$RAD9->setText("0");
	$RAD9->setCursor(new QCursor(2));
	$self->connect($RAD9,'pressed()','but0()');
	QToolTip::add($RAD9,'Zero button quite large and nice');

	my $RAD10 = new QPushButton($self)->immortal;
	$RAD10->setGeometry(87,138,30,30)
;
	$RAD10->setText(".");
	$RAD10->setCursor(new QCursor(2));
	$self->connect($RAD10,'pressed()','butdot()');
	QToolTip::add($RAD10,'... Doesnt work properly');

	my $RAD11 = new QPushButton($self)->immortal;
	$RAD11->setGeometry(119,107,28,61)
;
	$RAD11->setText("=");
	$RAD11->setCursor(new QCursor(2));
	$self->connect($RAD11,'pressed()','buteq()');
	QToolTip::add($RAD11,'Get answer to process');

	my $RAD12 = new QPushButton($self)->immortal;
	$RAD12->setGeometry(118,76,30,30)
;
	$RAD12->setText("+");
	$RAD12->setCursor(new QCursor(2));
	$self->connect($RAD12,'pressed()','butplus()');
	QToolTip::add($RAD12,'Plus Button');

	my $RAD13 = new QPushButton($self)->immortal;
	$RAD13->setGeometry(118,45,30,30)
;
	$RAD13->setText("-");
	$RAD13->setCursor(new QCursor(2));
	$self->connect($RAD13,'pressed()','butminus()');
	QToolTip::add($RAD13,'Minus Button');

	my $RAD14 = new QLabel($self)->immortal;
	$RAD14->setGeometry(25,7,155,31)
;
	$RAD14->setText("0");
	$RAD14->setAlignment($Align{Right});
	$RAD14->setCursor(new QCursor(2));
	$self->{messagebox} = $RAD14;
	QToolTip::add($RAD14,'Answer area');

	my $RAD15 = new QPushButton($self)->immortal;
	$RAD15->setGeometry(149,45,30,30)
;
	$RAD15->setText("*");
	$RAD15->setCursor(new QCursor(2));
	$self->connect($RAD15,'pressed()','multi()');
	QToolTip::add($RAD15,'Multiply a number');

	my $RAD16 = new QPushButton($self)->immortal;
	$RAD16->setGeometry(149,76,30,30)
;
	$RAD16->setText("/");
	$RAD16->setCursor(new QCursor(2));
	$self->connect($RAD16,'pressed()','divide()');
	QToolTip::add($RAD16,'Divide a number');

	my $RAD17 = new QPushButton($self)->immortal;
	$RAD17->setGeometry(149,107,30,30)
;
	$RAD17->setText("C/CE");
	$RAD17->setCursor(new QCursor(2));
	QToolTip::add($RAD17,'Clear dispaly');

	my $RAD18 = new QPushButton($self)->immortal;
	$RAD18->setGeometry(149,138,30,30)
;
	$RAD18->setText("AC");
	$RAD18->setCursor(new QCursor(2));
	$self->connect($RAD18,'pressed()','cleardisplayandmem()');
	QToolTip::add($RAD18,'Clear display and memory');

	my $RAD19 = new QLabel($self)->immortal;
	$RAD19->setGeometry(185,7,89,19)
;
	$RAD19->setText("<--- Result");
	$RAD19->setAlignment($Align{Center});
	$RAD19->setCursor(new QCursor(2));

	my $RAD20 = new QLabel($self)->immortal;
	$RAD20->setGeometry(210,45,92,17)
;
	$RAD20->setText("A Calculator");
	$RAD20->setAlignment($Align{Center});
	$RAD20->setCursor(new QCursor(2));

	my $RAD21 = new QLabel($self)->immortal;
	$RAD21->setGeometry(228,60,85,19)
;
	$RAD21->setText("By Fredead");
	$RAD21->setAlignment($Align{Center});
	$RAD21->setCursor(new QCursor(2));



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
	if ( $self->{'func'} eq 'multi' )
		{
		$self->{'screen'} = $self->{'memory'} * $self->{'screen'};
		$self->{'memory'} = 0;
		$self->updatescreen('');
		}
	if ( $self->{'func'} eq 'divide' )
		{
		$self->{'screen'} = $self->{'memory'} / $self->{'screen'};
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

sub cleardisplay {
	my $self = shift;
	$self->{'screen'} = 0;
	$self->updatescreen('');
}

sub cleardisplayandmem {
	my $self = shift;
	$self->{'memory'} = 0;
	$self->cleardisplay();
}

sub divide {
    my $self = shift;
    $self->{'func'} = 'divide';
    $self->{'memory'} = $self->{'screen'};
    $self->{'screen'} = 0;
    $self->updatescreen('');
}

sub multi {
	my $self = shift;
    $self->{'func'} = 'multi';
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
