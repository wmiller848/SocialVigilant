package main

import (
	"bufio"
	"fmt"
	"log"
	"net/http"

	"github.com/SlyMarbo/spdy"
	"github.com/mrjones/oauth"
)

func httpHandler(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "text/plain")
	w.Write([]byte("This is an example server.\n"))
}

func main() {
	fmt.Println("Social Vigilant")

	http.HandleFunc("/", httpHandler)
	log.Printf("About to listen on 1337. Go to https://127.0.0.1:1337/")
	err := spdy.ListenAndServeTLS(":1337", "sv_cert.pem", "sv_ukey.pem", nil)
	if err != nil {
		log.Fatal(err)
	}

	oauthConsumer := oauth.NewConsumer(
		"DxaP6uz4Bz69g4HbVVLqvfXNm",                          // Key
		"LoTrxhOn9CrjbZFHEMFJ7GJuycsNsd4mg7FO26EbXPbFVmNVTY", // Secret
		oauth.ServiceProvider{
			RequestTokenUrl:   "https://api.twitter.com/oauth/request_token",
			AuthorizeTokenUrl: "https://api.twitter.com/oauth/authorize",
			AccessTokenUrl:    "https://api.twitter.com/oauth/access_token",
		},
	)

	token := oauth.AccessToken{
		Token:  "3473456543-ajqYfTGsprxrHXtyl57Gkr77JEWwpPulNONsMto",
		Secret: "OmNKELfQa5rVOaltZOP29OWmy7EJw4NLCZKLRJF5uPlEe",
	}

	client, err := oauthConsumer.MakeHttpClient(&token)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	response, err := client.Get("https://userstream.twitter.com/1.1/user.json")
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	defer response.Body.Close()
	//
	// bits, err := ioutil.ReadAll(response.Body)
	// fmt.Println(string(bits))

	reader := bufio.NewReader(response.Body)
	for {
		line, err := reader.ReadBytes('\n')
		if err != nil {
			fmt.Println(err.Error())
			return
		}
		fmt.Println(string(line))
	}
}
