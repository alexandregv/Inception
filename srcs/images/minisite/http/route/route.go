package route

import (
	"github.com/alexandregv/inception/srcs/images/minisite/http/controller/pages"

	"goyave.dev/goyave/v3"
	"goyave.dev/goyave/v3/cors"
	"goyave.dev/goyave/v3/log"
)

// Register all the application routes. This is the main route registrer.
func Register(router *goyave.Router) {
	// Common Log Format middleware
	router.Middleware(log.CommonLogMiddleware())

	// Default CORS settings (allow all methods and all origins)
	router.CORS(cors.Default())

	// Index page
	router.Get("/", pages.Index).Name("pages.index")

	// Static slides, generated with Slidev (https://sli.dev)
	router.Static("/slides", "resources/static/slides", false)
}
