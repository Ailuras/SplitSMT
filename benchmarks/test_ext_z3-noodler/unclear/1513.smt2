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

(declare-sort var690 0)
(declare-sort var2632 0)
(declare-sort var2825 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun channel/1110566221 (var2632) Int)
(declare-fun cast-from-var690-to-var2632 (var690) var2632)
(declare-fun getText/1335168926 (var2632) String)
(declare-fun replaceAll/1692887130 (String String String) String)
(declare-fun getTokenIndex/-1918754661 (var690) Int)
(declare-fun getStartIndex/-704794108 (var690) Int)
(declare-fun getStopIndex/-952734122 (var690) Int)
(declare-fun getType/162231221 (var2632) Int)
(declare-fun getLine/1429753440 (var690) Int)
(declare-fun getCharPositionInLine/829202780 (var690) Int)
(declare-fun cast-from-Int-to-String (Int) String)
(declare-const null-var690 var690)
(declare-const null-String String)
(declare-const var2304 var690) ; Statement: r0 := @this: org.antlr.v4.parse.GrammarToken 
(assert (not (= var2304 null-var690)))
(define-const var3099 String "") ; Statement: r3 = "" 
(define-const var2864 Int (channel/1110566221 (cast-from-var690-to-var2632 var2304))) ; Statement: $i0 = r0.<org.antlr.v4.parse.GrammarToken: int channel> 
 ; Statement: if $i0 <= 0 goto $r2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: java.lang.String getText()>() 
(assert (<= var2864 0)) ; Cond: $i0 <= 0 
(assert true)
(define-const var2129 String (getText/1335168926 (cast-from-var690-to-var2632 var2304))) ; Statement: $r2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: java.lang.String getText()>() 
 ; Statement: if $r2 == null goto r6 = "<no text>" 
(assert (not (= var2129 null-String))) ; Negate: Cond: $r2 == null  
(assert true)
(define-const var883 String (replaceAll/1692887130 var2129 "\n" "\u005c\u005cn")) ; Statement: r4 = virtualinvoke $r2.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("\n", "\\\\n") 
(assert (= (replaceAll/1692887130 var2129 "\n" "\u005c\u005cn") (str.replace_re_all var2129 (str.to_re "\u{005c}u{000a}") "\u005c\u005cn")))
(assert true)
(define-const var1403 String (replaceAll/1692887130 var883 "\r" "\u005c\u005cr")) ; Statement: r5 = virtualinvoke r4.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("\r", "\\\\r") 
(assert (= (replaceAll/1692887130 var883 "\r" "\u005c\u005cr") (str.replace_re_all var883 (str.to_re "\u{005c}u{000d}") "\u005c\u005cr")))
(assert true)
(define-const var209 String (replaceAll/1692887130 var1403 "\t" "\u005c\u005ct")) ; Statement: r6 = virtualinvoke r5.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("\t", "\\\\t") 
(assert (= (replaceAll/1692887130 var1403 "\t" "\u005c\u005ct") (str.replace_re_all var1403 (str.to_re "\u{005c}u{0009}") "\u005c\u005ct")))
 ; Statement: goto [?= $i6 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getTokenIndex()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var1129 Int (getTokenIndex/-1918754661 var2304)) ; Statement: $i6 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getTokenIndex()>() 
(assert true)
(define-const var488 Int (getStartIndex/-704794108 var2304)) ; Statement: $i5 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getStartIndex()>() 
(assert true)
(define-const var169 Int (getStopIndex/-952734122 var2304)) ; Statement: $i4 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getStopIndex()>() 
(assert true)
(define-const var1848 Int (getType/162231221 (cast-from-var690-to-var2632 var2304))) ; Statement: $i3 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getType()>() 
(assert true)
(define-const var2326 Int (getLine/1429753440 var2304)) ; Statement: $i2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getLine()>() 
(assert true)
(define-const var2059 Int (getCharPositionInLine/829202780 var2304)) ; Statement: $i1 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getCharPositionInLine()>() 
(define-const var2518 String (str.++ "[@\u0001,\u0001:\u0001=\u0027\u0001\u0027,<\u0001>\u0001,\u0001:\u0001]" (cast-from-Int-to-String var1129) (cast-from-Int-to-String var488) (cast-from-Int-to-String var169) var209 (cast-from-Int-to-String var1848) var3099 (cast-from-Int-to-String var2326) (cast-from-Int-to-String var2059))) ; Statement: $r1 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int,int,int,java.lang.String,int,java.lang.String,int,int)>($i6, $i5, $i4, r6, $i3, r3, $i2, $i1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("[@\u0001,\u0001:\u0001=\'\u0001\',<\u0001>\u0001,\u0001:\u0001]") 
 ; Statement: return $r1 
(check-sat)
; {channel/1110566221=([org.antlr.runtime.CommonToken], int), cast-from-var690-to-var2632=([org.antlr.v4.parse.GrammarToken], org.antlr.runtime.CommonToken), getText/1335168926=([org.antlr.runtime.CommonToken], java.lang.String), replaceAll/1692887130=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), getTokenIndex/-1918754661=([org.antlr.v4.parse.GrammarToken], int), getStartIndex/-704794108=([org.antlr.v4.parse.GrammarToken], int), getStopIndex/-952734122=([org.antlr.v4.parse.GrammarToken], int), getType/162231221=([org.antlr.runtime.CommonToken], int), getLine/1429753440=([org.antlr.v4.parse.GrammarToken], int), getCharPositionInLine/829202780=([org.antlr.v4.parse.GrammarToken], int), cast-from-Int-to-String=([int], java.lang.String)}
; {var690=org.antlr.v4.parse.GrammarToken, var2304=r0, var3099=r3, var2632=org.antlr.runtime.CommonToken, var2864=$i0, var2129=$r2, var2825=null_type, var883=r4, var1403=r5, var209=r6, var1129=$i6, var488=$i5, var169=$i4, var1848=$i3, var2326=$i2, var2059=$i1, var2518=$r1}
; {org.antlr.v4.parse.GrammarToken=var690, r0=var2304, r3=var3099, org.antlr.runtime.CommonToken=var2632, $i0=var2864, $r2=var2129, null_type=var2825, r4=var883, r5=var1403, r6=var209, $i6=var1129, $i5=var488, $i4=var169, $i3=var1848, $i2=var2326, $i1=var2059, $r1=var2518}
;seq <java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>": 3}
;stmts r0 := @this: org.antlr.v4.parse.GrammarToken;	r3 = "";	$i0 = r0.<org.antlr.v4.parse.GrammarToken: int channel>;	if $i0 <= 0 goto $r2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: java.lang.String getText()>();	$r2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: java.lang.String getText()>();	if $r2 == null goto r6 = "<no text>";	r4 = virtualinvoke $r2.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("\n", "\\\\n");	r5 = virtualinvoke r4.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("\r", "\\\\r");	r6 = virtualinvoke r5.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("\t", "\\\\t");	goto [?= $i6 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getTokenIndex()>()];	$i6 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getTokenIndex()>();	$i5 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getStartIndex()>();	$i4 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getStopIndex()>();	$i3 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getType()>();	$i2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getLine()>();	$i1 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getCharPositionInLine()>();	$r1 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int,int,int,java.lang.String,int,java.lang.String,int,int)>($i6, $i5, $i4, r6, $i3, r3, $i2, $i1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("[@\u0001,\u0001:\u0001=\'\u0001\',<\u0001>\u0001,\u0001:\u0001]");	return $r1
;block_num 4