import java_cup.runtime.*;
      
%%
   
%class Lexer
%line
%column
%cup
   

%{   
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}


/////////////////////////////////////////////////////////////////////////////   

LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator}|[ \t\f]
Number = (0|[1-9][0-9]*)(\.[0-9]+)?((e|E)(\+|-)?[0-9]+)?
Boolean = true | false
   
%%
   
<YYINITIAL> {
   
	";" { return symbol(sym.SEMI); }
	"+"	{ System.out.print(" + "); return symbol(sym.PLUS);}
	"-"	{ System.out.print(" - "); return symbol(sym.MIN);}
	"*"     { System.out.print(" * "); return symbol(sym.MULT); }
 	"/"    { System.out.print(" / "); return symbol(sym.COS); }
        "//"    { System.out.print(" // "); return symbol(sym.DIV); }
        "%"     { System.out.print(" % "); return symbol(sym.MOD); }
	
	"=="	{ System.out.print(" == "); return symbol(sym.EQUAL);}
	"!="    { System.out.print(" != "); return symbol(sym.NOT_EQUAL);}
	"<"	{ System.out.print(" < "); return symbol(sym.LESS); }
	">"	{ System.out.print(" > "); return symbol(sym.GREATER); }
	"<="	{ System.out.print(" <= "); return symbol(sym.LESS_EQUAL); }
	">="	{ System.out.print(" >= "); return symbol(sym.GREATER_EQUAL); }
	
	"!"	{ System.out.print("!"); return symbol(sym.NOT); }
	"&&"	{ System.out.print("&&"); return symbol(sym.AND); }
	"||"	{ System.out.print("||"); return symbol(sym.OR); }

        "("     { System.out.print("("); return symbol(sym.LPARENT); }
        ")"     { System.out.print(")"); return symbol(sym.RPARENT); }
		
        {Number}     { System.out.print(yytext());  return symbol(sym.NUMBER, new Double(yytext()));}
	{Boolean}    { System.out.print(yytext()); return symbol(sym.BOOLEAN,new Boolean(yytext()));}	
   
        {WhiteSpace}       { /* nop */ }   
}

[^]                    { throw new Error("Illegal character <"+yytext()+">"); }
