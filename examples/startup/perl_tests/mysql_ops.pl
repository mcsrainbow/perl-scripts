#!/usr/bin/perl 

use DBI;
use strict;
use warnings;

# Connect
my $driver = "mysql";
my $database = "TESTDB";
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
my $sth = $dbh->prepare("INSERT IGNORE INTO TEST_TABLE
                        (FIRST_NAME,LAST_NAME,SEX,AGE,INCOME)
                         values
                        (?,?,?,?,?)");
$sth->execute($first_name,$last_name,$sex,$age,$income) 
            or die $DBI::errstr;
$sth->finish();
$dbh->commit or die $DBI::errstr;

# Read
$age = 29;
$sth = $dbh->prepare("SELECT FIRST_NAME,LAST_NAME
                         FROM TEST_TABLE
                         WHERE AGE > ?");
$sth->execute( $age ) or die $DBI::errstr;
print "Number of rows found: " ;
print $sth->rows;
while (my @row = $sth->fetchrow_array()) {
  my ($first_name, $last_name ) = @row;
  print "\nFirst Name = $first_name, Last Name = $last_name";
}
$sth->finish();

# Update
$sex = 'M';
$income = 10000;
$sth = $dbh->prepare("UPDATE TEST_TABLE
                         SET INCOME = ?
                         WHERE SEX = ?");
$sth->execute( $income, $sex ) or die $DBI::errstr;
print "\nNumber of rows updated: ";
print $sth->rows;
$sth->finish();
$dbh->commit or die $DBI::errstr;

# Delete
$age = 30;
$sth = $dbh->prepare("DELETE FROM TEST_TABLE
                         WHERE AGE = ?");
$sth->execute( $age ) or die $DBI::errstr;
print "\nNumber of rows deleted: ";
print $sth->rows;
print "\n";
$sth->finish();
#$dbh->commit or die $DBI::errstr;

# Do
#$dbh->do("DELETE FROM TEST_TABLE WHERE age = 30");

# Rollback
$dbh->rollback or die $dbh->errstr;
