package MyAWS::Object::Instance::State;

=head1 NAME

MyAWS::Object::State - Object describing the state of an EC2 instance

=head1 SYNOPSIS

  use MyAWS;

  $aws      = MyAWS->new(...);
  $instance = $aws->describe_instances(-instance_id=>'i-12345');
  $state    = $instance->state;
  $code     = $state->code;
  $name     = $state->name;

=head1 DESCRIPTION

This object represents the state of an Amazon EC2 instance.  It is
returned by calling the state() method of an MyAWS::Object::Instance,
and is also returned by MyAWS->start_instances(), stop_instances() and
terminate_instances().

=head1 METHODS

These object methods are supported:
 
 code           -- The state code
 name           -- The state name

   Code	                           Name
   ----                            -------
    0                              pending
   16                              running
   32                              shutting-down
   48                              terminated
   64                              stopping
   80                              stopped
  272                              <none>

Code 272 is said to correspond to a problem with the instance host.

=head1 STRING OVERLOADING

When used in a string context, this object will interpolate the
name.

=head1 SEE ALSO

L<MyAWS>
L<MyAWS::Object::Base>
L<MyAWS::Object::State>
L<MyAWS::Object::Instance>

=head1 AUTHOR

Lincoln Stein E<lt>lincoln.stein@gmail.comE<gt>.

Copyright (c) 2011 Ontario Institute for Cancer Research

This package and its accompanying libraries is free software; you can
redistribute it and/or modify it under the terms of the GPL (either
version 1, or at your option, any later version) or the Artistic
License 2.0.  Refer to LICENSE for the full license text. In addition,
please see DISCLAIMER.txt for disclaimers of warranty.

=cut

use strict;
use overload '""'     => 'name',
             fallback => 1;

sub new {
    my $self  = shift;
    my $state = shift;
    return bless \$state,ref $self || $self;
}

sub code { ${shift()}->{code} }
sub name { ${shift()}->{name} }

1;
