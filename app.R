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
    tags$li(tags$a("Sub page", href = "/#!/subpage"))
  ),
  router_ui(
    route("/", main_page()), # want this at
    route("subpage", sub_page()) # want this at
  )
)

server <- function(input, output, session) {
  shiny.router::router_server()
}

shinyApp(ui = ui, server = server)
