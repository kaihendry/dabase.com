---
title: UK vs SG income tax for the salary man
date: 2024-06-16T13:22:05+01:00
description: Visualising income tax bands between the UK and Singapore
---

<img src="https://s.natalian.org/2024-06-17/tax_bands.png" alt="Tax Bands: SG vs UK">

Source:
* https://www.iras.gov.sg/taxes/individual-income-tax/basics-of-individual-income-tax/tax-residency-and-tax-rates/individual-income-tax-rates
* https://www.gov.uk/government/publications/rates-and-allowances-income-tax/income-tax-rates-and-allowances-current-and-past

I assumed the exchange rate of 1 GBP to 1.7 SGD.

GnuPlot script:

    set terminal pngcairo size 1024,768 enhanced font 'Verdana,10'
    set output 'tax_bands.png'

    set datafile separator comma
    set key left top
    set title "Tax Bands: SG vs UK"
    set xlabel "Threshold in SGD"
    set ylabel "Tax Rate (%)"
    set grid
    set xrange [0:300000]
    set yrange [0:50]
    set xtics (0, 8500, 20000, 30000, 40000, 64090, 80000, 120000, 160000, 200000)
    set xtics rotate by 90 right

    # Define the data for Singapore
    $sg_data << EOD
    threshold in SGD,tax rate %
    0,0
    20000,2
    30000,3.5
    40000,7
    80000,11.5
    120000,15
    160000,18
    200000,19
    280000,19.5
    320000,22
    500000,23
    1000000,24
    EOD

    # 5000GBP * 1.7 = 8500SGD
    $uk_data << EOD
    threshold in SGD,tax rate %
    0,0
    8500,20
    64090,40
    212739,45
    999999999,45 
    EOD

    plot $sg_data using 1:2 with steps title "Singapore" lt rgb "blue", \
         $uk_data using 1:2 with steps title "United Kingdom" lt rgb "red"

Any tips on how to improve this visualisation?
