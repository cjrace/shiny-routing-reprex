library(shiny)

ui <- fluidPage(
  tags$ul(
    tags$li(actionLink("main_page", "Main page")),
    tags$li(actionLink("sub_page", "Sub page"))
  ),
  tabsetPanel(
    id = "switcher",
    type = "hidden",
    tabPanelBody(value = "main", div(h1("Main page"), p("Some main text."))),
    tabPanelBody(value = "sub", div(h1("Sub page"), p("Some subtext.")))
  )
)

server <- function(input, output, session) {
  observeEvent(input$main_page, {
    updateTabsetPanel(inputId = "switcher", selected = "main")
  })
  observeEvent(input$sub_page, {
    updateTabsetPanel(inputId = "switcher", selected = "sub")
  })
  observeEvent(getQueryString(session)$page, {
    currentQueryString <- getQueryString(session)$page # alternative: parseQueryString(session$clientData$url_search)$page
    if(is.null(input$switcher) || !is.null(currentQueryString) && currentQueryString != input$switcher){
      freezeReactiveValue(input, "switcher")
      updateTabsetPanel(session, "switcher", selected = currentQueryString)
    }
  }, priority = 1)
  
  observeEvent(input$switcher, {
    currentQueryString <- getQueryString(session)$page # alternative: parseQueryString(session$clientData$url_search)$page
    pushQueryString <- paste0("?page=", input$switcher)
    if(is.null(currentQueryString) || currentQueryString != input$switcher){
      freezeReactiveValue(input, "switcher")
      updateQueryString(pushQueryString, mode = "push", session)
    }
  }, priority = 0)
}

shinyApp(ui = ui, server = server)
