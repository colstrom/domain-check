#!/usr/bin/env node
/**
 * @author Chris Olstrom
 */

console.log('DomainCheck v2011.12.04 -- Copyright (c) 2010-2011 Chris Olstrom');

var argv = require('optimist')
	.usage('Usage: $0')
	.default({
		'api'	:'reseller.enom.com/interface.asp'
	})
	.boolean('insecure')
	.alias('api','a')
	.alias('username','u')
	.alias('password','p')
	.demand('username')
	.demand('password')
	.describe('api','Which API to query')
	.describe('username','Username for target API')
	.describe('password','Password for target API')
	.describe('domain','Query status of this domain')
	.describe('insecure','Do not use SSL')
	.demand('domain')
	.argv;