(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1391 0)
(declare-sort var3208 0)
(declare-sort var2507 0)
(declare-sort var1858 0)
(declare-sort var2724 0)
(declare-sort var640 0)
(declare-sort var387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2507-init () var2507)
(declare-fun <init>/1804829395 (var2507 String) void)
(declare-fun fontMetrics/1203940574 (var1391) var2507)
(declare-fun getFont/-178000676 (var2507) var1858)
(declare-fun getPSName/-1890397057 (var1858) String)
(declare-fun fontName/1203940574 (var1391) String)
(declare-fun fontSize/1203940574 (var1391) Int)
(declare-fun var2724_get/1088891777 (var2724 var640) var640)
(declare-fun cast-from-String-to-var640 (String) var640)
(declare-fun cast-from-var640-to-String (var640) String)
(declare-fun ps/1203940574 (var1391) String)
(declare-fun arr-var640-init () (Array Int var640))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var640 (Int) var640)
(declare-fun String_format/-647569892 (var387 String (Array Int var640)) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var1391 var1391)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1391-POSTSCRIPT_FONT_NAMES var2724)
(declare-const var387-US var387)
(declare-const null-__Array__Int__var640__ (Array Int var640))
(declare-const var3118 var1391) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var3118 null-var1391)))
(declare-const var2721 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2721 null-String)))
(declare-const var3008 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3008 null-Int)))
(define-const var3833 var2507 var2507-init) ; Statement: $r1 = new org.antlr.v4.gui.SystemFontMetrics 
(assert true)
;(assert (<init>/1804829395 var3833 var2721)) ; Statement: specialinvoke $r1.<org.antlr.v4.gui.SystemFontMetrics: void <init>(java.lang.String)>(r2) 

(declare-const var3833!1 var2507)
(declare-const var2721!1 String)
(declare-const var3118!1 var1391)
(assert (not (= var3118!1 null-var1391)))
(assert (= (fontMetrics/1203940574 var3118!1) var3833!1)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: org.antlr.v4.gui.SystemFontMetrics fontMetrics> = $r1 
(define-const var1133 var2507 (fontMetrics/1203940574 var3118!1)) ; Statement: $r3 = r0.<org.antlr.v4.gui.PostScriptDocument: org.antlr.v4.gui.SystemFontMetrics fontMetrics> 
(assert true)
(define-const var620 var1858 (getFont/-178000676 var1133)) ; Statement: $r4 = virtualinvoke $r3.<org.antlr.v4.gui.SystemFontMetrics: java.awt.Font getFont()>() 
(assert true)
(define-const var2811 String (getPSName/-1890397057 var620)) ; Statement: $r5 = virtualinvoke $r4.<java.awt.Font: java.lang.String getPSName()>() 
(declare-const var3118!2 var1391)
(assert (not (= var3118!2 null-var1391)))
(assert (= (fontName/1203940574 var3118!2) var2811)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.String fontName> = $r5 
(declare-const var3118!3 var1391)
(assert (not (= var3118!3 null-var1391)))
(assert (= (fontSize/1203940574 var3118!3) var3008)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: int fontSize> = i0 
(define-const var3175 var2724 var1391-POSTSCRIPT_FONT_NAMES) ; Statement: $r7 = <org.antlr.v4.gui.PostScriptDocument: java.util.Map POSTSCRIPT_FONT_NAMES> 
(define-const var2591 String (fontName/1203940574 var3118!3)) ; Statement: $r6 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.String fontName> 
(define-const var125 var640 (var2724_get/1088891777 var3175 (cast-from-String-to-var640 var2591))) ; Statement: $r8 = interfaceinvoke $r7.<java.util.Map: java.lang.Object get(java.lang.Object)>($r6) 
(define-const var1778 String (cast-from-var640-to-String var125)) ; Statement: r14 = (java.lang.String) $r8 
 ; Statement: if r14 != null goto $r10 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(assert (not (= var1778 null-String))) ; Cond: r14 != null 
(define-const var2517 String (ps/1203940574 var3118!3)) ; Statement: $r10 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(define-const var3209 var387 var387-US) ; Statement: $r11 = <java.util.Locale: java.util.Locale US> 
(define-const var1818 (Array Int var640) arr-var640-init) ; Statement: $r9 = newarray (java.lang.Object)[2] 
(declare-const var1818!1 (Array Int var640))
(assert (not (= var1818!1 null-__Array__Int__var640__)))
(assert (= (select var1818!1 0) (cast-from-String-to-var640 var1778))) ; Statement: $r9[0] = r14 
(define-const var637 Int (Int_valueOf/-1371140006 var3008)) ; Statement: $r12 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var1818!2 (Array Int var640))
(assert (not (= var1818!2 null-__Array__Int__var640__)))
(assert (= (select var1818!2 1) (cast-from-Int-to-var640 var637))) ; Statement: $r9[1] = $r12 
(define-const var175 String (String_format/-647569892 var3209 "/%s findfont %d scalefont setfont\n" var1818!2)) ; Statement: $r13 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r11, "/%s findfont %d scalefont setfont\n", $r9) 
(assert true)
;(assert (append/672562846 var2517 var175)) ; Statement: virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var2517!1 String)
(assert (= var2517!1 (str.++ var2517 var175)))
 ; Statement: return 
(check-sat)
; {var2507-init=([], org.antlr.v4.gui.SystemFontMetrics), <init>/1804829395=([org.antlr.v4.gui.SystemFontMetrics, java.lang.String], void), fontMetrics/1203940574=([org.antlr.v4.gui.PostScriptDocument], org.antlr.v4.gui.SystemFontMetrics), getFont/-178000676=([org.antlr.v4.gui.SystemFontMetrics], java.awt.Font), getPSName/-1890397057=([java.awt.Font], java.lang.String), fontName/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.String), fontSize/1203940574=([org.antlr.v4.gui.PostScriptDocument], int), var2724_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var640=([java.lang.String], java.lang.Object), cast-from-var640-to-String=([java.lang.Object], java.lang.String), ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), arr-var640-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var640=([java.lang.Integer], java.lang.Object), String_format/-647569892=([java.util.Locale, java.lang.String, java.lang.Object[]], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var1391=org.antlr.v4.gui.PostScriptDocument, var3118=r0, var2721=r2, var3208=null_type, var3008=i0, var2507=org.antlr.v4.gui.SystemFontMetrics, var3833=$r1, var1133=$r3, var1858=java.awt.Font, var620=$r4, var2811=$r5, var2724=java.util.Map, var3175=$r7, var2591=$r6, var640=java.lang.Object, var125=$r8, var1778=r14, var2517=$r10, var387=java.util.Locale, var3209=$r11, var1818=$r9, var637=$r12, var175=$r13}
; {org.antlr.v4.gui.PostScriptDocument=var1391, r0=var3118, r2=var2721, null_type=var3208, i0=var3008, org.antlr.v4.gui.SystemFontMetrics=var2507, $r1=var3833, $r3=var1133, java.awt.Font=var1858, $r4=var620, $r5=var2811, java.util.Map=var2724, $r7=var3175, $r6=var2591, java.lang.Object=var640, $r8=var125, r14=var1778, $r10=var2517, java.util.Locale=var387, $r11=var3209, $r9=var1818, $r12=var637, $r13=var175}
;seq <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	r2 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r1 = new org.antlr.v4.gui.SystemFontMetrics;	specialinvoke $r1.<org.antlr.v4.gui.SystemFontMetrics: void <init>(java.lang.String)>(r2);	r0.<org.antlr.v4.gui.PostScriptDocument: org.antlr.v4.gui.SystemFontMetrics fontMetrics> = $r1;	$r3 = r0.<org.antlr.v4.gui.PostScriptDocument: org.antlr.v4.gui.SystemFontMetrics fontMetrics>;	$r4 = virtualinvoke $r3.<org.antlr.v4.gui.SystemFontMetrics: java.awt.Font getFont()>();	$r5 = virtualinvoke $r4.<java.awt.Font: java.lang.String getPSName()>();	r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.String fontName> = $r5;	r0.<org.antlr.v4.gui.PostScriptDocument: int fontSize> = i0;	$r7 = <org.antlr.v4.gui.PostScriptDocument: java.util.Map POSTSCRIPT_FONT_NAMES>;	$r6 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.String fontName>;	$r8 = interfaceinvoke $r7.<java.util.Map: java.lang.Object get(java.lang.Object)>($r6);	r14 = (java.lang.String) $r8;	if r14 != null goto $r10 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r10 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r11 = <java.util.Locale: java.util.Locale US>;	$r9 = newarray (java.lang.Object)[2];	$r9[0] = r14;	$r12 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r9[1] = $r12;	$r13 = staticinvoke <java.lang.String: java.lang.String format(java.util.Locale,java.lang.String,java.lang.Object[])>($r11, "/%s findfont %d scalefont setfont\n", $r9);	virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	return
;block_num 2