#!/usr/bin/env perl

use strict;
use warnings;
use MIME::Lite;
use Authen::SASL;

foreach my $a ( 1 .. 10 ) {
  sleep 10;
  my $from = 'myname@domain.com';
  my $passwd = 'mypasswd';
  my $to = 'jack@domain.com';
  my $cc = 'tonny@domain.com';
  my $subject = $a . ":" . "Hello $from";
  my $messages = $a . ":" . "Hello $from";
  
  my $msg = MIME::Lite->new(
    From    => $from,
    To      => $to,
    Cc      => $cc,
    Subject => $subject,
    Type    => 'TEXT',
    Data    => $messages,
  );
  
  MIME::Lite->send('smtp','smtp.domain.com',
    Debug   => '1',
    AuthUser => $from,
    AuthPass => $passwd,
  );

  $msg->send;
}
