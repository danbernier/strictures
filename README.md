# Strictures

## What?

Strictures is a ruby gem for defining requirements on objects.

It's like Rails validations, say, or RSpec's argument matchers,
but you can use them however you want to.

To make this work, you need to be able to do three things:

1. define rules for how your data should look
2. check your data against those rules
3. see the results, and use them in your code

For example, with Rails validations, you define the rules on your models, and
Rails handles running them against your form data, and gives you a hash of the
violations.

With RSpec argument matchers, you can define some (very basic) rules about what
arguments can be passed to your method to meet the expectation, and if the
actual parameters don't match, the spec fails.

## Why?

Say you're working with some third-party API - REST, SOAP, whatever. And the
data format is poorly documented. And it changes. Often. Without notice.
And it's not really public - maybe it's developed by some in-house IT shop,
and you're basically its only consumer.

A defensive layer would be nice, right? So you figure out what the data is
supposed to look like (for now, anyway), and you write a bunch of if-statements
that check each bundle of data. Cram them into your handle-response method
somewhere. Each time you do this, it's a bit ad-hoc, and so is handling the
error results.

Dammit, is there a gem for this somewhere?

Yep. It's called Strictures.

## How?

	Strictures.check('foo', Strictures.any(String)).valid?  #=> true
	Strictures.check(42, Strictures.any(String)).valid?     #=> false
	Strictures.check(42, Strictures.any(String)).errors
		#=> ["Expected a String, got a Fixnum: 42"]

	class ResponseValidator
		extends Strictures

		# ...um?
	end

	ResponseValidator.new.validate(response) #=> {}

Here's the original sketch of syntax I started with:

	resp = { status: 'success',
	          code: 42,
	          deets: {
	            name: 'Peet',
	            age: 11
	          }
	        }

	puts assert(resp, status: any(Symbol),
	              code: either(5, 23),
	              deets: {
	                name: /@[A-Z][a-z]+/,
	                age: 0..100
	              })

That should print:

* For :status, expected a Symbol, got: "success"
* For :code, expected one of 5, 23, got: 42
* For :deets / :name, expected something like (?-mix:@[A-Z][a-z]+), got: "Peet"













# TODOs

For the Project:

* Code Climate! :heart:
* Set up Travis.
* .gemspec, all that stuff

For the code:

* Check structure of Hashes & Arrays recursively.
* Let you add your own Rules. Maybe just let you add Procs, maybe that's enough.
* Let you handle violations in a callback object? Maybe that's crap, not sure yet.
* All ___kinds___ of stuff, who am I kidding? I'm just hacking here. Give me some time.
