HANDLERS := $(notdir $(shell ls handlers))

define genBuild
$(1):
	go mod download
	GOARCH=amd64 GOOS=linux go build -o build/$(1)/$(1) handlers/$(1)/main.go

endef
$(foreach d,${HANDLERS},$(eval $(call genBuild,$(d))))

define genTest
test-$(1):
	go mod download
	go test handlers/$(1)/main.go

endef
$(foreach d,${HANDLERS},$(eval $(call genTest,$(d))))

define build
	make $(1)

endef

define test
	make test-$(1)

endef

all:
	$(foreach d,${HANDLERS},$(call build,$(d)))

test:
	$(foreach d,${HANDLERS},$(call test,$(d)))

clean:
	rm -rf build
