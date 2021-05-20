package pages

import (
	"net/http"

	"goyave.dev/goyave/v3"
)

// Called by the pages.index route (path: "/")
func Index(response *goyave.Response, request *goyave.Request) {
	err := response.RenderHTML(http.StatusOK, "index.html", nil)
	if  err != nil {
		response.Error(err)
	}
}
