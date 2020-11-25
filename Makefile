.PHONY: destroy deploy invalidate listinvalidations test destroy

destroy:
	./node_modules/.bin/serverless remove

deploy:
	node ./validate.js
	./node_modules/.bin/serverless deploy
	CLOUDFRONT_DISTRIBUTION_ID="${E2ZWGMQVWJRCEW}" node deploy.js
	CLOUDFRONT_DISTRIBUTION_ID="${E2ZWGMQVWJRCEW}" node create-invalidation.js

invalidate:
	CLOUDFRONT_DISTRIBUTION_ID="${E2ZWGMQVWJRCEW}" node create-invalidation.js

listinvalidations:
	aws cloudfront list-invalidations --distribution-id "" | head

test:
	DEBUG=prerendercloud PRERENDER_SERVICE_URL="https://service.prerender.cloud" ./node_modules/jasmine/bin/jasmine.js
