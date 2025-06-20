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

(declare-sort var2883 0)
(declare-sort var3051 0)
(declare-sort var3109 0)
(declare-sort var3319 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun input/448264395 (var3109) var3051)
(declare-fun cast-from-var2883-to-var3109 (var2883) var3109)
(declare-fun var3051_LA/-940427205 (var3051 Int) Int)
(declare-fun match/-1386024108 (var3109 String) void)
(declare-fun state/448264395 (var3109) var3319)
(declare-fun failed/1780090535 (var3319) Bool)
(declare-const null-var2883 var2883)
(declare-const var1194 var2883) ; Statement: r1 := @this: org.antlr.v4.parse.ActionSplitter 
(assert (not (= var1194 null-var2883)))
(define-const var3381 String String-init) ; Statement: $r51 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3381)) ; Statement: specialinvoke $r51.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3381!1 String)
(assert (= var3381!1 ""))
(define-const var3590 Int 0) ; Statement: i24 = 0 
(assert true) ; Non Conditional
(define-const var3435 Int 5) ; Statement: b25 = 5 
(define-const var1765 var3051 (input/448264395 (cast-from-var2883-to-var3109 var1194))) ; Statement: $r2 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input> 
(define-const var2544 Int (var3051_LA/-940427205 var1765 1)) ; Statement: $i2 = interfaceinvoke $r2.<org.antlr.runtime.CharStream: int LA(int)>(1) 
 ; Statement: if $i2 < 0 goto (branch) 
(assert (not (< var2544 0))) ; Negate: Cond: $i2 < 0  
 ; Statement: if $i2 <= 35 goto b25 = 1 
(assert (<= var2544 35)) ; Cond: $i2 <= 35 
(define-const var3435!1 Int 1) ; Statement: b25 = 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: tableswitch(b25) {     case 1: goto $r26 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;     case 2: goto virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(java.lang.String)>("\\$");     case 3: goto virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(int)>(92);     case 4: goto $r3 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;     default: goto if i24 < 1 goto $r38 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state>; } 
(assert (and (= var3435!1 2) (and (not (= var3435!1 1)) true))) ; Intersect: Cond: b25 == 2  and Intersect: Negate: Cond: b25 == 1   and Non Conditional  
(assert true)
;(assert (match/-1386024108 (cast-from-var2883-to-var3109 var1194) "\u005c$")) ; Statement: virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(java.lang.String)>("\\$") 

(declare-const var1194!1 var2883)
(declare-const var1952 String)
(define-const var2998 var3319 (state/448264395 (cast-from-var2883-to-var3109 var1194!1))) ; Statement: $r24 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state> 
(define-const var2693 Bool (failed/1780090535 var2998)) ; Statement: $z3 = $r24.<org.antlr.runtime.RecognizerSharedState: boolean failed> 
 ; Statement: if $z3 == 0 goto $r25 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state> 
(assert (not (= (ite var2693 1 0) 0))) ; Negate: Cond: $z3 == 0  
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), input/448264395=([org.antlr.runtime.Lexer], org.antlr.runtime.CharStream), cast-from-var2883-to-var3109=([org.antlr.v4.parse.ActionSplitter], org.antlr.runtime.Lexer), var3051_LA/-940427205=([org.antlr.runtime.CharStream, int], int), match/-1386024108=([org.antlr.runtime.Lexer, java.lang.String], void), state/448264395=([org.antlr.runtime.Lexer], org.antlr.runtime.RecognizerSharedState), failed/1780090535=([org.antlr.runtime.RecognizerSharedState], boolean)}
; {var2883=org.antlr.v4.parse.ActionSplitter, var1194=r1, var3381=$r51, var3590=i24, var3435=b25, var3051=org.antlr.runtime.CharStream, var3109=org.antlr.runtime.Lexer, var1765=$r2, var2544=$i2, var1952="\\$", var3319=org.antlr.runtime.RecognizerSharedState, var2998=$r24, var2693=$z3}
; {org.antlr.v4.parse.ActionSplitter=var2883, r1=var1194, $r51=var3381, i24=var3590, b25=var3435, org.antlr.runtime.CharStream=var3051, org.antlr.runtime.Lexer=var3109, $r2=var1765, $i2=var2544, "\\$"=var1952, org.antlr.runtime.RecognizerSharedState=var3319, $r24=var2998, $z3=var2693}
;seq <java.lang.StringBuilder: void <init>()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1}
;stmts r1 := @this: org.antlr.v4.parse.ActionSplitter;	$r51 = new java.lang.StringBuilder;	specialinvoke $r51.<java.lang.StringBuilder: void <init>()>();	i24 = 0;	b25 = 5;	$r2 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;	$i2 = interfaceinvoke $r2.<org.antlr.runtime.CharStream: int LA(int)>(1);	if $i2 < 0 goto (branch);	if $i2 <= 35 goto b25 = 1;	b25 = 1;	goto [?= (branch)];	tableswitch(b25) {     case 1: goto $r26 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;     case 2: goto virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(java.lang.String)>("\\$");     case 3: goto virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(int)>(92);     case 4: goto $r3 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;     default: goto if i24 < 1 goto $r38 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state>; };	virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(java.lang.String)>("\\$");	$r24 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state>;	$z3 = $r24.<org.antlr.runtime.RecognizerSharedState: boolean failed>;	if $z3 == 0 goto $r25 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state>;	return
;block_num 7