package main
import (
    "os/exec"
    "github.com/gin-gonic/gin"
)

func main() {
    router := gin.Default()
    router.LoadHTMLGlob("templates/*.html")
    out, _ := exec.Command("git", "rev-parse", "--short", "HEAD").Output()
    data := "Hello Go!!" + string(out)
    router.GET("/", func(ctx *gin.Context){
        ctx.HTML(200, "index.html", gin.H{"data": data})
    })

    router.Run()
}

