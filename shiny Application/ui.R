shinyUI(
  pageWithSidebar(
    #Application title
    headerPanel("Calculate BMI"),
    
    
    sidebarPanel(
      numericInput('weight', 'Enter your weight in Kg',0, min= 0, max =300, step =1),
      numericInput('height','Enter your height in meters',0, min = 0, max = 4, step=0.3),
      dateInput("date", "Date:"),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Results of prediction'),
      h4('You entered'),
      verbatimTextOutput("inputValue1"),
      h4('you entered'),
      verbatimTextOutput("inputValue2"),
      h4('You entered'),
      verbatimTextOutput("odate"),
      h4("Which resulted in a prediction of"),
      verbatimTextOutput("prediction")
    )
    
  )
)