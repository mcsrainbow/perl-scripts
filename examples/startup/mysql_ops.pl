#!/usr/bin/env perl

use DBI;
use strict;
use warnings;

# Connect
my $driver = "mysql";
my $database = "testdb";
my $hostname = "localhost";
my $socket = "/opt/mysql/run/mysqld.sock";
my $autocommit = "0";
my $dsn = "DBI:$driver:database=$database:host=$hostname:mysql_socket=$socket";
my $userid = "testuser";
my $password = "test123";
my $dbh = DBI->connect($dsn, $userid, $password, {AutoCommit => $autocommit})
            or die $DBI::errstr;

my $first_name = "John";
my $last_name = "Paul";
my $sex = "M";
my $age = 30;
my $income = 13000;

# Insert
my $sth = $dbh->prepare("INSERT IGNORE INTO test_table
                        (first_name,last_name,sex,age,income)
                         values
                        (?,?,?,?,?)");
$sth->execute($first_name,$last_name,$sex,$age,$income) 
            or die $DBI::errstr;
$sth->finish();
$dbh->commit or die $DBI::errstr;

# Read
$age = 29;
$sth = $dbh->prepare("SELECT first_name,last_name
                         FROM test_table
                         WHERE age > ?");
$sth->execute( $age ) or die $DBI::errstr;
print "Number of rows found: " . $sth->rows . "\n";
while (my @row = $sth->fetchrow_array()) {
  my ($first_name, $last_name ) = @row;
  print "First Name = $first_name, Last Name = $last_name" . "\n";
}
$sth->finish();

# Update
$sex = 'M';
$income = 10000;
$sth = $dbh->prepare("UPDATE test_table
                         SET income = ?
                         WHERE sex = ?");
$sth->execute( $income, $sex ) or die $DBI::errstr;
print "Number of rows updated: " . $sth->rows . "\n";
$sth->finish();
$dbh->commit or die $DBI::errstr;

# Delete
$age = 30;
$sth = $dbh->prepare("DELETE FROM test_table
                         WHERE age = ?");
$sth->execute( $age ) or die $DBI::errstr;
print "Number of rows deleted: " . $sth->rows . "\n";
$sth->finish();
#$dbh->commit or die $DBI::errstr;

# Do
#$dbh->do("DELETE FROM test_table WHERE age = 30");

# Rollback
$dbh->rollback or die $dbh->errstr;
