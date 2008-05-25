set title "Bessel Functions J_0, J_1, J_2, J_3, J_4, J_5"

plot "bessel.data" using 1:7 t 'J_5' with lines, "bessel.data" using 1:6 t 'J_4' with lines, "bessel.data" using 1:5 t 'J_3' with lines, "bessel.data" using 1:4 t 'J_2' with lines, "bessel.data" using 1:3 t 'J_1' with lines, "bessel.data" using 1:2 title 'J_0' with lines 
