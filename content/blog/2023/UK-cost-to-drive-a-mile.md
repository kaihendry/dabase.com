---
title: UK Cost to Drive a Mile
date: 2023-08-07T12:00:20+01:00
description: Comparing the cost to drive a mile in the UK between gasoline and electric vehicles
---

<div>
    <label for="kwh">Cost per kWh (in pence): </label>
    <input type="range" id="kwh" min="0" max="150" step="1" value="20">
    <span id="kwhValue">20</span>
</div>

<div>
    <label for="litre">Cost per litre (in pence): </label>
    <input type="range" id="litre" min="0" max="250" step="1" value="150">
    <span id="litreValue">150</span>
</div>

<h3>Cost per Mile</h3>
<div>Electric Vehicle: <span id="evCost">5.26</span> pence/mile</div>
<div>Gasoline Car: <span id="gasolineCost">18.945</span> pence/mile</div>

<script>
    const kwhInput = document.getElementById('kwh');
    const litreInput = document.getElementById('litre');
    const kwhValue = document.getElementById('kwhValue');
    const litreValue = document.getElementById('litreValue');
    const evCost = document.getElementById('evCost');
    const gasolineCost = document.getElementById('gasolineCost');

    const EV_CONSUMPTION = 0.263; // kWh/mi
    const GASOLINE_EFFICIENCY = 7.92; // miles/litre

    kwhInput.addEventListener('input', updateValues);
    litreInput.addEventListener('input', updateValues);

    function updateValues() {
        kwhValue.textContent = kwhInput.value;
        litreValue.textContent = litreInput.value;

        evCost.textContent = (EV_CONSUMPTION * kwhInput.value).toFixed(2);
        gasolineCost.textContent = (1 / GASOLINE_EFFICIENCY * litreInput.value).toFixed(2);
    }

    updateValues();  // Call once to initialize

</script>



# If an Electric Vehicle consumes 263 Wh/mi, and the cost of a kw/h is 20 pence, how much does it cost to drive 1 mile?

To find the cost of driving 1 mile:

1. Convert the consumption to kWh/mi:
263 Wh/mi = 0.263 kWh/mi

2. Multiply the consumption per mile by the cost per kWh:
0.263 kWh/mi × 20 pence/kWh

= 5.26 pence/mi

So, it costs 5.26 pence to drive 1 mile in that Electric Vehicle given the specified consumption and energy cost.

# If the cost per litre of fuel is 150p, and a typical gasoline car has about 36 MPG, how much does it cost to drive one mile?

Convert the fuel efficiency from MPG to MPL (miles per litre):
36 miles/4.54609 litres = 7.92 miles/litre

Find out how much fuel is used for 1 mile:
1 mile/7.92 miles/litre = 0.1263 litres

Calculate the cost to drive one mile:
0.1263 litres × 150p/litre = 18.945 pence


# Conclusion

As of August 2023, it's almost **four times cheaper to drive a mile in an electric vehicle** than a gasoline vehicle.

Lets not forget the other benefits of electric vehicles, such as:
* cleaner air
* less noise pollution
* less maintenance
* cleaner over time as the [electricity grid becomes greener](https://grid.iamkate.com/)

Thanks to [Jujhar Singh](https://linkedin.com/in/jujhar) for pointing out my initial mistake in the calculation and this [Car Fuel Cost Calculator](https://www.fleetnews.co.uk/costs/fuel-cost-calculator/?FuelType=Unleaded&PencePerLitre=143.73&Mileage=1&ManufacturerId=30&Mpg=36)