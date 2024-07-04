GOFLAGS_LINUX=-trimpath -ldflags "-s -w"
GOFLAGS_WINDOWS=-trimpath -ldflags "-s -w" #-H=windowsgui"
GOFLAGS_MACOS=-trimpath -ldflags "-s -w"
GOOS ?= linux
GOARCH ?= amd64

DEFAULT_ENV=CGO_ENABLED=0

all:
	@echo
	@echo "Please specify one of these targets:"
	@echo "	make linux"
	@echo "	make windows"
	@echo "	make macos"
	@echo
	@echo "It can be compiled to other unix-like platforms supported by go compiler:"
	@echo "	GOOS=freebsd GOARCH=386 make unix"
	@echo
	@echo "Get more with:"
	@echo "	go tool dist list"
	@echo

windows:
	env ${DEFAULT_ENV} GOOS=windows GOARCH=amd64 go build ${GOFLAGS_WINDOWS} -o ./build/tshd_windows_amd64.exe cmd/tshd.go
	env ${DEFAULT_ENV} GOOS=windows GOARCH=amd64 go build ${GOFLAGS_WINDOWS} -o ./build/tsh_windows_amd64.exe cmd/tsh.go

linux:
	env ${DEFAULT_ENV} GOOS=linux GOARCH=amd64 go build ${GOFLAGS_LINUX} -o ./build/tshd_linux_amd64 cmd/tshd.go
	env ${DEFAULT_ENV} GOOS=linux GOARCH=amd64 go build ${GOFLAGS_LINUX} -o ./build/tsh_linux_amd64 cmd/tsh.go

macos:
	env ${DEFAULT_ENV} GOOS=darwin GOARCH=amd64 go build ${GOFLAGS_MACOS} -o ./build/tshd_darwin_amd64 cmd/tshd.go
	env ${DEFAULT_ENV} GOOS=darwin GOARCH=amd64 go build ${GOFLAGS_MACOS} -o ./build/tsh_darwin_amd64 cmd/tsh.go
	env ${DEFAULT_ENV} GOOS=darwin GOARCH=arm64 go build ${GOFLAGS_MACOS} -o ./build/tshd_darwin_arm64 cmd/tshd.go
	env ${DEFAULT_ENV} GOOS=darwin GOARCH=arm64 go build ${GOFLAGS_MACOS} -o ./build/tsh_darwin_arm64 cmd/tsh.go

unix:
	env ${DEFAULT_ENV} GOOS=${GOOS} GOARCH=${GOARCH} go build ${GOFLAGS_LINUX} -o ./build/tshd_${GOOS}_${GOARCH} cmd/tshd.go
	env ${DEFAULT_ENV} GOOS=${GOOS} GOARCH=${GOARCH} go build ${GOFLAGS_LINUX} -o ./build/tsh_${GOOS}_${GOARCH} cmd/tsh.go

clean:
	rm ./build/*

.PHONY: all clean windows linux macos unix
	