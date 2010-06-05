use strict;
use warnings;
use Test::More tests => 13;
my @xdata = qw(
  0.7199 0.7462 0.7550 0.7638 0.7726 0.7813 0.7901 0.7989 0.8077
  0.8164 0.8252 0.8340 0.8428 0.8516 0.8603 0.8691 0.8779 0.8867
  0.8955 0.9042 0.9130 0.9218 0.9306 0.9394 0.9481 0.9569 0.9657
  0.9745 0.9832 0.9920 1.0008 1.0096 1.0184 1.0271 1.0359 1.0447
  1.0535 1.0623 1.0710 1.0798 1.0886 1.0974 1.1062 1.1149 1.1237
  1.1325 1.1500
);

my @ydata = qw(
  0.8255 0.7894 0.7728 0.7547 0.7156 0.7064 0.6861 0.6720 0.6495
  0.6376 0.6228 0.5929 0.5869 0.5599 0.5388 0.5272 0.4980 0.4775
  0.4610 0.4383 0.4168 0.3984 0.3779 0.3582 0.3426 0.3253 0.3069
  0.2922 0.2754 0.2614 0.2619 0.2476 0.2367 0.2271 0.2189 0.2176
  0.2171 0.2198 0.2260 0.2483 0.2595 0.2572 0.2858 0.2950 0.3134
  0.3176 0.3792
);

my @parameters = ( 
                [ 's', 4.0, 0.01 ],
                [ 'c', 0.01, 0.001 ],
                [ 'y0', 0.1, 0.001 ],
                [ 'x0', 1.0535, 0.01 ],
              );

use Algorithm::CurveFit;

Algorithm::CurveFit->curve_fit(
  formula            => 'sqrt( s*(x-x0)^2 + c) + y0',
  variable           => 'x',
  params             => \@parameters,
  xdata              => \@xdata,
  ydata              => \@ydata,
  maximum_iterations => 20,
);

#use Data::Dumper;
#print Dumper \@parameters;

ok(@parameters == 4);
my @val = (5.15, 0.01, 0.100, 1.045);
my @eps = (1.00, 0.10, 1.000, 0.100);

foreach my $par (0..$#parameters) {
  my $v = $parameters[$par][1];
  ok(defined $v);
  ok($v + $eps[$par] > $val[$par]);
  ok($v - $eps[$par] < $val[$par]);
}
