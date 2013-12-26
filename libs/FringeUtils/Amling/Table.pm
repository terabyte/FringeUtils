# Copyright (C) 2010   Keith Amling, keith.amling@gmail.com
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

package FringeUtils::Amling::Table;

use strict;
use warnings;

sub format_table
{
    my $table = shift;

    my @w;

    for my $row (@$table)
    {
        for(my $col = 0; $col < @$row; ++$col)
        {
            my $cell = $row->[$col];

            until($col < @w)
            {
                push @w, 0;
            }

            if($cell->[0] ne '-')
            {
                if($w[$col] < length($cell->[1]))
                {
                    $w[$col] = length($cell->[1]);
                }
            }
        }
    }

    my $s = "";
    for my $row (@$table)
    {
        my @row;
        for(my $col = 0; $col < @$row; ++$col)
        {
            my $cell = $row->[$col];
            my $w = $w[$col];

            if($cell->[0] eq '-')
            {
                push @row, ("-" x $w);
            }
            elsif($cell->[0] eq 'R')
            {
                push @row, ((" " x ($w - length($cell->[1]))) . $cell->[1]);
            }
            elsif($cell->[0] eq 'L')
            {
                push @row, ($cell->[1] .  (" " x ($w - length($cell->[1]))));
            }
            else
            {
                die;
            }
        }
        $s .= join("   ", @row) . "\n";
    }

    return $s;
}

1;
