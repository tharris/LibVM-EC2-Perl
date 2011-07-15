package MyAWS::Object::Group;

=head1 NAME

MyAWS::Object::Group - Object describing an Amazon EC2 security group name

=head1 SYNOPSIS

  use MyAWS;

  $aws      = MyAWS->new(...);
  $instance = $aws->describe_instances(-instance_id=>'i-12345');
  my @groups = $instance->groups;
  for my $g (@groups) {
    my $id      = $g->groupId;
    my $name    = $g->groupName;

    # get the security group details
    my $sg      = $aws->describe_security_group($g);
    my $permissions = $sg->ipPermissions;
  }

=head1 DESCRIPTION

This object represents the name and ID of a security group. It is
returned by an instance's groups() method. This object does not
provide any of the details about the security group, but you can use
it in a call to MyAWS->describe_security_group() to get details about
the security group's allowed ports, etc.

=head1 METHODS

These object methods are supported:

 groupId   -- the group ID
 groupName -- the group's name

For convenience, the object also provides a permissions() method that
will return the fully detailed MyAWS::Object::SecurityGroup:

 $details = $group->permissions()

See L<MyAWS::Object::SecurityGroup>

=head1 STRING OVERLOADING

When used in a string context, this object will interpolate the
groupId.

=head1 SEE ALSO

L<MyAWS>
L<MyAWS::Object>
L<MyAWS::Object::Base>
L<MyAWS::Object::SecurityGroup>

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
use base 'MyAWS::Object::Base';

sub valid_fields {
    my $self  = shift;
    return $self->SUPER::valid_fields,
           qw(groupId groupName);
}

sub primary_id { shift->groupId }

sub permissions {
    my $self = shift;
    return $self->{perm} if exists $self->{perm};
    my @sg   = $self->aws->describe_security_groups(-group_id=>$self->groupId);
    return unless @sg;
    die "more than one security group returned?" if @sg > 1;
    return $self->{perm} = $sg[0];
}

1;

