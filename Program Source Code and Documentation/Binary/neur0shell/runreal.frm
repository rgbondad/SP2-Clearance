??, ?  y   	RunRealty? 1NeuroShell 2 Interactive Runtime Network  Example?  ?  ?  d   B #?             ?     (       @         ?                        ?  ?   ?? ?   ? ? ??  ??? ???   ?  ?   ?? ?   ? ? ??  ???    wwww wp       ?wwp ww      ?    ?? wp     ? w    	? ? 	 wp   	?????????? p               ????	????     ???~??? ??         ?  ??      ?????????         ??????     ????????x     ???  ?????     ??????????x     ?  ?p ???     ???p???x     ???p????     ? ??p??w     ?  ?p ??w     wwwwwwwww?w               w    ???wwx???w      ???  x??ww     ????x??w?wp     ??{???ww?      ? ??wwwp      p????xww       w???wwwp       w ??wxw          ?wwwp                   ? ?? ?? ?   ?      ?  ??  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?   ?? ?? ?? ?? ?? ?? ??? $Form15?  6?  7?  8d  ?:   Text6??
?.Jc:\nshell2\examples\realty.def  ?   no? Noop?; ?   yes? Yes??  ?   acres?
W ?   feet?W ?   baths???	W ?   rooms???W ?   bedrooms??bW ?3  ?
 Check1? Low price range ???;  ?6  ?
 Check1? Medium price range ?
??;  ?4  ?
  Check1? High price range  ??  ?   Quit? Quit|?7?	 ?1   CallNet? Fire Neural Network?l?
g ?5   Label8? Path to definition file:?(??  ?#   	Label7? Acres:?2
F?  ?&   Label6? 	Bedrooms:??V?  ?,   Label5? Eat In Kitchen???F?  ?&   Label4? 	Sq. Feet:???  ?#   Label3? Baths:?P
??  ?)   Label2? Other rooms:???? 
 ?T  Label1? ?5This example (Visual Basic source code included) interactively executes the Realty network. First make sure the window below shows the corrent path to the REALTY.DEF file. Enter house characteristics from the list below. Then push the Fire Network button. Remember, these prices are relative to Frederick, MD!?x ?G ?X  ?  __	 
?Q?Q?   ?   ?? ? =v   ? ?   Z t??<U  ? ?? (?'? ?g ?                   ?  ? 	Form_Load
 Grid1_Click?  Command1_Click?  grid1? ColE Row? Text?  ColWidth   ColumnWidth? width?  if Cols6 Command3_Click? FireNet? inputs? outputs? 
InputArray
 OutputArrayq iInputArrayT problemname8 problempath~ Command2_Click MaxCols? allowarrowsedit? 
ProcessTab* ArrowsExitEditMode? AllowUserFormulas   SelectFig_Click] 
Quit_click? problempath2   SetMath   CallNet_ClickX SetCPUM InitDLLh DLLInit   
getnextnet   j? Label3_Click   OpenNet   cE nshell2   testexam? realtyL def Label1_Click0 Text6_Changeh label6? txt room? rooms   highest? Check2_Click? Check3_Click   Check1_Click   Index   check1? mshbox   baths^ feet   bedroomst acres   yes? text6| Value   lowest   CloseNet   when   we   	netnumber   Form_Unload   Cancel   rooms_Change   	netisopen   acres_Change   bedrooms_Change   feet_Change?      ;     ? L   
  v * "  this is where the inputs and outputs go    ? ? ? ? v #   the number of inputs and outputsu    ? ? ?v #    the number assigned to this nett    ? ? ?v &    makes sure net is only opened once	  ????????
    CallNet_Click 4v	     X  ?     ? D ? ^v !   temporary variables used below       v >     the path to the definition file is supposed to be in text6  v 5    in your program you can call the common dialog box   v :    to have the user select its location, or you can always  v #    put the file in a fixed locationt     ?? I &v    open it only once  L ?  ? ?  ?   M ? v * 7  open the network and get the net number  ? ? ? I  ? " ? Error returned from OpenNet:   ? ? ? ?  ? 
  Error & = ?	 8  , ?  8     v <    in this case we know in advance the number of inputs and   v 8    outputs, so we will check to see if they are correct.  v ?    It may be the case that your program doesn't know in advancee  v ?    in which case it will use the values it obtains from OpenNet.  v     without any checking.     ? ??  ? ?? ? I   ? p tj Number of inputs or outputs in selected .DEF file is incorrect. Inputs should be 6 and outputs should be 3  ?  ? 
 ? Error & = ?	  8     v .    Make arrays to hold your inputs and outputs    ?  
 v     make sure they are doubles    ?   v 
   doubles    v .    put the inputs into the array from the form  v <    They must go in the same order they were presented during  v     training of the network   0 ? ? ?  
   ? ? ? ?  
    ? ? ?  
   ( ? ? ?  
   EI ? ??  
  2 ? ? ?  
  8      < ? ? ?  
    v 9    now pass the inputs to the network, which will fill ini  v 
    outputs   ??  
?    ?  ?    ? ? ? I ? ? " H Error returned from FireNet:   ? ? ? ?  ? 
 z Error & = ?	  8     v 3    now find the lowest output which is the "winner"   v /    if using Kohonen normalized find the highestf  ? ^v %   assume first is the lowest for nowo   ? ??> ??v  ?    ^  ? I l  ?  ^ 8    ? N ??     v "    clear all the check boxes first   ? ? ?> ??? ?  ?    U   ? N ??     v 0    note in the realty example the highest price   v 1    correlated with the first category, the medium   v 2    prices with the second category, and the lowest  v 1    with the third. This is how the check1 controlt  v     array was arranged to match    ? ^??    Uv +   control array begins with zero subscripto      v 9    note the net is closed in the quit button and the formr  v /    unload procedure when we're all done with itn  9 	  ????????R    
 Quit_click 4?      X  ?     ?  ?      ?  h ? v    close the network  v .    ignore error in case no net ever was opened    7   9 	  ????????   ?