package main

import (
	"os"
	"log"

	"github.com/alexandregv/inception/srcs/images/minisite/http/route"

	"goyave.dev/goyave/v3"
)

func initLogger() {
	goyave.Logger = log.New(os.Stdout, "[minisite] ", log.Ldate | log.Ltime | log.Lshortfile)

	goyave.Logger.Println("Starting...")
	goyave.RegisterStartupHook(func() {
		goyave.Logger.Println("Started.")
	})
}

func main() {
	initLogger()

	if err := goyave.Start(route.Register); err != nil {
		os.Exit(err.(*goyave.Error).ExitCode)
	}
}
