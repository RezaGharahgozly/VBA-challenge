Attribute VB_Name = "RibbonX_Code"

Sub Wall_Street()
For Each ws In ActiveWorkbook.Worksheets
ws.Activate
  ' Set an initial variable for holding the Ticker
  Dim Ticker As String

  ' Set an initial variable for holding the Total Stock Volume
  Dim TotalStockVolume As Double
  TotalStockVolume = 0

Dim sht As Worksheet
Set sht = ActiveSheet
  
  Dim Summary_Table_Row As Integer, LastRow As Double, j As Integer, k As Integer
  Dim maxticker As String, minticker As String, nameGTV As String, open1 As Single, close1 As Double
  Dim NewLastRow As Double, max As Single, min As Single, GTV As Double
  Summary_Table_Row = 2
  ' set the headers
  Range("j1") = "Ticker"
  Range("K1") = "YearlyChange"
  Range("L1") = "PercentChange"
  Range("M1") = "TotalStockVolume"
  Range("Q2") = "Greatest%Increase"
  Range("Q3") = "Greatest%Decrease"
  Range("Q4") = "GreatestTotalValue"
  Range("R1") = "Ticker"
  Range("S1") = "Value"
  ' number of rows
   LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

 ' Loop through all tickers
  For i = 2 To LastRow

    ' Check if we are still within the same ticker, if it is not...
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then

      ' Set the ticker name
      Ticker = Cells(i, 1).Value
close1 = Cells(i, 6).Value
open1 = Cells(i + 1, 3).Value
      ' Add to the TotalStockVolume
     TotalStockVolume = TotalStockVolume + Cells(i, 7).Value

      ' Print the ticker name in the Summary Table
      Range("J" & Summary_Table_Row).Value = Ticker
      ' Print the TotalStockVolume to the Summary Table
      Range("M" & Summary_Table_Row).Value = TotalStockVolume
Range("O" & Summary_Table_Row + 1).Value = open1
Range("P" & Summary_Table_Row).Value = close1
      ' Add one to the summary table row
      Summary_Table_Row = Summary_Table_Row + 1
      
      ' Reset the TotalStockVolume Total
      TotalStockVolume = 0

    ' If the cell immediately following a row is the same ticker...
    Else

      ' Add to the TotalStockVolume
      TotalStockVolume = TotalStockVolume + Cells(i, 7).Value

    End If

  Next i
' set number of new rows
NewLastRow = ws.Cells(Rows.Count, 10).End(xlUp).Row
' extra but useful columns, at the end we will clear them
For j = 2 To NewLastRow
Range("K" & j).Value = Range("P" & j).Value - Range("O" & j).Value
    'if there are some divided by 0
    If Range("O" & j).Value = 0 Then
    Range("O" & j).Value = 0.1
    End If
    Range("L" & j).Value = Round(((Range("k" & j).Value / Range("O" & j).Value) * 100), 2) & "%"
    
    If Range("K" & j).Value > 1 Then
    Range("K" & j).Interior.ColorIndex = 4
    Else: Range("K" & j).Interior.ColorIndex = 3
    End If
Next j
'first Open manually
Range("O2").Value = Range("C2")
'last close manually
Range("P" & NewLastRow).Value = Range("F" & LastRow)
' finding greatest increse, decrease and total value
max = 0
min = 0
GTV = 0
For k = 2 To NewLastRow
    If Range("K" & k).Value > max Then
    max = Range("K" & k).Value
    maxticker = Range("J" & k).Value
    ElseIf Range("K" & k).Value < min Then
    min = Range("K" & k).Value
    minticker = Range("J" & k).Value
    End If

    If Range("M" & k).Value > GTV Then
    GTV = Range("M" & k).Value
    nameGTV = Range("J" & k).Value
    End If
Next k
'set the headers
Range("S2").Value = max
Range("s3").Value = min
Range("R2").Value = maxticker
Range("R3").Value = minticker
Range("S4").Value = GTV
Range("R4").Value = nameGTV
'cleanning extra columns
    Range("O:P").Clear
Next ws
End Sub
