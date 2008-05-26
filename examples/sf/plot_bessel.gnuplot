set title "Bessel Functions J_0(x), J_1(x), J_2(x), J_3(x), J_4(x), J_5(x)"

set terminal png
set output "bessel.png"

plot "bessel.data" using 1:7 t 'J_5(x)' with lines, "bessel.data" using 1:6 t 'J_4(x)' with lines, "bessel.data" using 1:5 t 'J_3(x)' with lines, "bessel.data" using 1:4 t 'J_2(x)' with lines, "bessel.data" using 1:3 t 'J_1(x)' with lines, "bessel.data" using 1:2 title 'J_0(x)' with lines 

unset output
set terminal x11

replot
