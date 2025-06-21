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

(declare-sort var2611 0)
(declare-sort var2758 0)
(declare-sort var2463 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun channel/1110566221 (var2758) Int)
(declare-fun cast-from-var2611-to-var2758 (var2611) var2758)
(declare-fun getText/1335168926 (var2758) String)
(declare-fun getTokenIndex/-1918754661 (var2611) Int)
(declare-fun getStartIndex/-704794108 (var2611) Int)
(declare-fun getStopIndex/-952734122 (var2611) Int)
(declare-fun getType/162231221 (var2758) Int)
(declare-fun getLine/1429753440 (var2611) Int)
(declare-fun getCharPositionInLine/829202780 (var2611) Int)
(declare-fun cast-from-Int-to-String (Int) String)
(declare-const null-var2611 var2611)
(declare-const null-String String)
(declare-const var1361 var2611) ; Statement: r0 := @this: org.antlr.v4.parse.GrammarToken 
(assert (not (= var1361 null-var2611)))
(define-const var3852 String "") ; Statement: r3 = "" 
(define-const var573 Int (channel/1110566221 (cast-from-var2611-to-var2758 var1361))) ; Statement: $i0 = r0.<org.antlr.v4.parse.GrammarToken: int channel> 
 ; Statement: if $i0 <= 0 goto $r2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: java.lang.String getText()>() 
(assert (<= var573 0)) ; Cond: $i0 <= 0 
(assert true)
(define-const var3786 String (getText/1335168926 (cast-from-var2611-to-var2758 var1361))) ; Statement: $r2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: java.lang.String getText()>() 
 ; Statement: if $r2 == null goto r6 = "<no text>" 
(assert (= var3786 null-String)) ; Cond: $r2 == null 
(define-const var2943 String "<no text>") ; Statement: r6 = "<no text>" 
(assert true) ; Non Conditional
(assert true)
(define-const var298 Int (getTokenIndex/-1918754661 var1361)) ; Statement: $i6 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getTokenIndex()>() 
(assert true)
(define-const var2723 Int (getStartIndex/-704794108 var1361)) ; Statement: $i5 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getStartIndex()>() 
(assert true)
(define-const var2106 Int (getStopIndex/-952734122 var1361)) ; Statement: $i4 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getStopIndex()>() 
(assert true)
(define-const var2098 Int (getType/162231221 (cast-from-var2611-to-var2758 var1361))) ; Statement: $i3 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getType()>() 
(assert true)
(define-const var3609 Int (getLine/1429753440 var1361)) ; Statement: $i2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getLine()>() 
(assert true)
(define-const var1478 Int (getCharPositionInLine/829202780 var1361)) ; Statement: $i1 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getCharPositionInLine()>() 
(define-const var775 String (str.++ "[@\u0001,\u0001:\u0001=\u0027\u0001\u0027,<\u0001>\u0001,\u0001:\u0001]" (cast-from-Int-to-String var298) (cast-from-Int-to-String var2723) (cast-from-Int-to-String var2106) var2943 (cast-from-Int-to-String var2098) var3852 (cast-from-Int-to-String var3609) (cast-from-Int-to-String var1478))) ; Statement: $r1 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int,int,int,java.lang.String,int,java.lang.String,int,int)>($i6, $i5, $i4, r6, $i3, r3, $i2, $i1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("[@\u0001,\u0001:\u0001=\'\u0001\',<\u0001>\u0001,\u0001:\u0001]") 
 ; Statement: return $r1 
(check-sat)
; {channel/1110566221=([org.antlr.runtime.CommonToken], int), cast-from-var2611-to-var2758=([org.antlr.v4.parse.GrammarToken], org.antlr.runtime.CommonToken), getText/1335168926=([org.antlr.runtime.CommonToken], java.lang.String), getTokenIndex/-1918754661=([org.antlr.v4.parse.GrammarToken], int), getStartIndex/-704794108=([org.antlr.v4.parse.GrammarToken], int), getStopIndex/-952734122=([org.antlr.v4.parse.GrammarToken], int), getType/162231221=([org.antlr.runtime.CommonToken], int), getLine/1429753440=([org.antlr.v4.parse.GrammarToken], int), getCharPositionInLine/829202780=([org.antlr.v4.parse.GrammarToken], int), cast-from-Int-to-String=([int], java.lang.String)}
; {var2611=org.antlr.v4.parse.GrammarToken, var1361=r0, var3852=r3, var2758=org.antlr.runtime.CommonToken, var573=$i0, var3786=$r2, var2463=null_type, var2943=r6, var298=$i6, var2723=$i5, var2106=$i4, var2098=$i3, var3609=$i2, var1478=$i1, var775=$r1}
; {org.antlr.v4.parse.GrammarToken=var2611, r0=var1361, r3=var3852, org.antlr.runtime.CommonToken=var2758, $i0=var573, $r2=var3786, null_type=var2463, r6=var2943, $i6=var298, $i5=var2723, $i4=var2106, $i3=var2098, $i2=var3609, $i1=var1478, $r1=var775}
;seq 
;cnt {}
;stmts r0 := @this: org.antlr.v4.parse.GrammarToken;	r3 = "";	$i0 = r0.<org.antlr.v4.parse.GrammarToken: int channel>;	if $i0 <= 0 goto $r2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: java.lang.String getText()>();	$r2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: java.lang.String getText()>();	if $r2 == null goto r6 = "<no text>";	r6 = "<no text>";	$i6 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getTokenIndex()>();	$i5 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getStartIndex()>();	$i4 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getStopIndex()>();	$i3 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getType()>();	$i2 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getLine()>();	$i1 = virtualinvoke r0.<org.antlr.v4.parse.GrammarToken: int getCharPositionInLine()>();	$r1 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (int,int,int,java.lang.String,int,java.lang.String,int,int)>($i6, $i5, $i4, r6, $i3, r3, $i2, $i1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("[@\u0001,\u0001:\u0001=\'\u0001\',<\u0001>\u0001,\u0001:\u0001]");	return $r1
;block_num 4