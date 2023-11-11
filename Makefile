GO_FLAGS := '-gcflags=all=-N -l'

all: $(notdir $(wildcard cmd/*))

$(notdir $(wildcard cmd/*)): $(shell find . -name '*.go')
	CGO_ENABLED=0 go build $(GO_FLAGS) -o $@ ./cmd/$@

.PHONY: release
release:
	$(MAKE) clean
	$(MAKE) GO_FLAGS="'-ldflags=-s -w -buildid=' -trimpath"

.PHONY: lint
lint: bin/golangci-lint
	./bin/golangci-lint run ./...

.PHONY: gen
gen:
	go generate ./...

.PHONY: test
test:
	go test -v ./...

bin/golangci-lint:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(PWD)/bin v1.54.2

audit: bin/trivy
	./bin/trivy fs --scanners vuln .

bin/trivy:
	curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b $(PWD)/bin v0.45.1

.PHONY: clean
clean:
	rm -rf bin $(notdir $(wildcard cmd/*))
