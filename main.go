package main

import (
	"fmt"
	"bufio"
	"github.com/mrjones/oauth"
)

func main() {
	fmt.Println("Social Vigilant")
	oauthConsumer := oauth.NewConsumer(
		"DxaP6uz4Bz69g4HbVVLqvfXNm", // Key
		"LoTrxhOn9CrjbZFHEMFJ7GJuycsNsd4mg7FO26EbXPbFVmNVTY", // Secret
		oauth.ServiceProvider {
			RequestTokenUrl:   "https://api.twitter.com/oauth/request_token",
			AuthorizeTokenUrl: "https://api.twitter.com/oauth/authorize",
			AccessTokenUrl:    "https://api.twitter.com/oauth/access_token",
		},
	)

	token := oauth.AccessToken {
		Token: "3473456543-ajqYfTGsprxrHXtyl57Gkr77JEWwpPulNONsMto",
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
