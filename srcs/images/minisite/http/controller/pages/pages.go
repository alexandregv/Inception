package pages

import (
	"net/http"

	"goyave.dev/goyave/v3"
)

// Called by the pages.index route (path: "/")
func Index(response *goyave.Response, request *goyave.Request) {
	response.String(http.StatusOK, "Hello, World!\nI made some presentation slides with the awesome <a href=\"https://sli.dev\">Slidev</a> tool, check them <a href=\"/slides\">here</a>.")
}
