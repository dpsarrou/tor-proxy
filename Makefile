build:
	@docker build . -t cminor/tor-proxy:latest

publish: build
	@docker push cminor/tor-proxy:latest