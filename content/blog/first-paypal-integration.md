---
title: My first Payment integration
date: 2021-10-24T07:41:00+08:00
description: My first experience of Paypal was great, then it got weird
---

After watching @[coolaj86](https://twitter.com/coolaj86)'s
[streams](https://youtu.be/2JjHmUSjuB0) for learning Javascript (again) AND
entertainment, I can't help recall my fairly painless Paypal experience.

Allow me to show you how I took [people's money in 2007](https://webconverger.org/acknowledgements/).

# How a payment is made

It's just HTML!

	<form class="pull-right" accept-charset="UTF-8" action="https://www.sandbox.paypal.com/cgi-bin/webscr" id="paypal_service_form" method="post">
	<input id="item_number" name="item_number" type="hidden" value="<?php echo $orderno; ?>" />
	<input id="custom" name="custom" type="hidden" value="<?php echo $orderno; ?>" />
	<input id="business" name="business" type="hidden" value="payments+sandbox@webconverger.com" />
	<input id="amount" name="amount" type="hidden" value="<?php echo $rate; ?>" />
	<input id="currency_code" name="currency_code" type="hidden" value="<?php echo $currency; ?>" />
	<input id="cmd" name="cmd" type="hidden" value="_ext-enter" />
	<input id="redirect_cmd" name="redirect_cmd" type="hidden" value="_xclick" />
	<input id="quantity" name="quantity" type="hidden" value="<?php echo $quantity; ?>" />
	<input id="item_name" name="item_name" type="hidden" value="<?php echo $desc; ?>" />
	<input id="no_shipping" name="no_shipping" type="hidden" value="1" />
	<input id="no_note" name="no_note" type="hidden" value="1" />
	<input id="charset" name="charset" type="hidden" value="utf-8" />
	<input id="invoice" name="invoice" type="hidden" value="<?php echo $current_url; ?>" />
	<input id="return" name="return" type="hidden" value="<?php echo $current_url; ?>" />
	<input id="cancel_return" name="cancel_return" type="hidden" value="<?php echo $current_url; ?>" />
	<input id="notify_url" name="notify_url" type="hidden" value="https://config.webconverger.com/inv/paypal-notification/" />
	<input type=submit value="Make payment of <?php echo money_format('%i', $amount); ?>">
	</form>

In my checkout page I include some PHP where I am careful to set amount / order
number. When that **form is submitted** the customer is then on the Paypal site
entering their credit card or rather Paypal is forcing them to open a Paypal
account (they changed their flows and UI over the years).

Anyway from my perspective, I had to now **wait for a HTTP request** (Web hook)
from Paypal to know whether the payment had gone through.

# How the Web hook works

Paypal called this the
[IPN](https://developer.paypal.com/docs/api-basics/notifications/ipn/) and this
is my PHP implementation, notice it simply uses **files instead of a database**.

For example when a user signs up [on my
site](https://config.webconverger.com/), the configuration is in "tmp", until
that person pays, in which case it becomes active and moves to
"install-config".

	<?php
	include 'email.php';

	function logs($s) {
		syslog(LOG_INFO, $_POST['custom']." $s");
	}

	// Kill a sub
	function zero($uuid, $old) {
		$src = "/srv/www/config.webconverger.com/clients/$old/$uuid";
		$fh = fopen($src, "w");
		fclose($fh);
	}

	// Change state of subscription by moving a file
	function mv($uuid, $old, $new) {
		$src = "/srv/www/config.webconverger.com/clients/$old/$uuid";
		if ( ! file_exists( $src ) ) {
			logs("no config found for $src");
			return;
		}
		$dst = "/srv/www/config.webconverger.com/clients/$new/$uuid";

		if ( is_link( $dst ) ) {
			logs("$dst is using the control panel: http://config.webconverger.com/client/" . readlink($dst));
			return;
		}

		if ( file_exists( $dst ) ) {
			unlink( $dst );
		}
		if ( ! rename( $src, $dst) ) {
			logs("could not rename $src to $dst");
			return;
		}
		logs("moved from $src to $dst ");
	}

	function noop($txn, $uuid) {
		logs("no action required for txn type $txn");
	}

	function txn_logs($uuid, $type, $id) {
		$now = time();
		$fh = fopen("//srv/www/config.webconverger.com/clients/paypal/$uuid", "a");
		fwrite($fh, "$now $id $type " . $_POST['payer_email'] . "\n");
		fclose($fh);
	}

	function main() {
		$uuid = $_POST['custom'];
		if ( $uuid == "" ) {
			logs("no UUID from PayPal?");
			return;
		}

		$txn = $_POST['txn_type'];
		if ( $txn == "" ) {
			logs("no TXN Type from PayPal?");
			return;
		}

		$txn_id = $_POST['txn_id'];
		logs( "received txn type $txn with id $txn_id" );
		txn_logs($uuid, $txn, $txn_id);

		switch ( $txn ) {
			case 'cart':
			case 'web_accept':
			case 'subscr_payment':
			case 'subscr_signup':
				mv( $uuid, 'tmp', 'install-config' ); break;
			case 'subscr_cancel':
			case 'subscr_eot':
				mv( $uuid, 'install-config', 'tmp' );
				zero( $uuid, 'install-config' );
				break;
			default:
				noop($txn, $uuid); break;
		}
	}

	main();
	mailpost();
	?>

After looking at 10+ year old code (still in use), I must say I write
professional code pretty much the same way my whole career:

1. [Always be logging](https://youtu.be/YlrwDN7_vHw)
2. Use a case / switch statement to explain the actions you are taking (or not)

My first payment integration was less than ~150 LOC.

# Conclusion

As I mention in my [2015 Payment methods
comparison](https://youtu.be/uJI0WxXTvTw?t=62), Paypal was my favourite and
first "payments integration". That said, Paypal did make this this "IPN" style
really hard / confusing in ~2010+. For example I could swear there was a
**period of years** where the <abbr title="Instant Payment
Notification">IPN</abbr> documentation could not be found at all on the Paypal
site as they were pushing their Braintree acquisition (I assume).

Fast forward to 2021 and for new Payment integrations I would reach for Stripe
with https://useshoppingcart.com/ as I did with
https://github.com/kaihendry/shopfront. You can see I [much prefer
static](https://youtu.be/9TkttbV0Ydg) checkout flows instead of dynamic ones.
