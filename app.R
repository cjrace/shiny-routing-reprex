library(shiny)
library(shiny.router)

main_page <- function() {
  div(
    h1("Main page"),
    p("Some main text.")
  )
}

sub_page <- function() {
  div(
    h1("Sub page"),
    p("Some subtext.")
  )
}

ui <- fluidPage(
  tags$ul(
    tags$li(tags$a("Main page", href = "/")),
    tags$li(tags$a("Sub page", href = "/#!/subpage")) # This works locally, but can't find the URL for this when deployed
  ),
  router_ui(
    route("/", main_page()), # This appears at https://cjrace.shinyapps.io/shiny-routing-reprex/ after a slight delay and redirecting to https://cjrace.shinyapps.io/shiny-routing-reprex/_w_9c312d7b/#!/
    route("subpage", sub_page())
  )
)

server <- function(input, output, session) {
  shiny.router::router_server()
}

shinyApp(ui = ui, server = server)
