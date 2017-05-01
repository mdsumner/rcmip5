
library(shiny)
library(dplyr)
library(RSQLite)
library(DT)
#f <-  file.path(getOption("default.datadir"), "data", "climate-cms.unsw.wikispaces.net", "file", "view", "cmip5_raijin.db", "553966810", "cmip5_raijin.db") 
#file.copy(f, basename(f))
#u <- "http://climate-cms.unsw.wikispaces.net/file/view/cmip5_raijin.db/553966810/cmip5_raijin.db"
#download.file(u, basename(u), mode = "wb")
cmip5 <- tbl(src_sqlite("cmip5_raijin.db"), "cmip5") %>% collect() 
cmip5 <- cmip5  %>% select_(.dots = c(setdiff(names(cmip5), "id"), "id"))

library(shiny)
shinyApp(
  ui = fluidPage(DT::dataTableOutput('tbl')),
  server = function(input, output) {
    output$tbl = DT::renderDataTable(
      cmip5, 
      filter = "top", class = 'cell-border stripe',
      options = list(lengthMenu = c(15, 25, 50, 101), autoWidth = TRUE)
    )
  }
)

